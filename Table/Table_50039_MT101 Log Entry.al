table 50039 "MT101 Log Entry"
{
    Caption = 'MT101 Log Entry';
    DataCaptionFields = "Account Type", "Account No.", "Jnl. Document No.";
    DrillDownPageID = "MT101 Log Reg. Entries";
    LookupPageID = "MT101 Log Reg. Entries";

    fields
    {
        field(1; "MT101 Log Register No."; Integer)
        {
            Caption = 'MT101 Log Register No.';
            TableRelation = "MT101 Log Register";
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor;
        }
        field(5; "Applies-to Entry No."; Integer)
        {
            Caption = 'Applies-to Entry No.';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Cust. Ledger Entry"
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Ledger Entry";
        }
        field(6; "Jnl. Posting Date"; Date)
        {
            Caption = 'Jnl. Posting Date';
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(8; "Jnl. Amount"; Decimal)
        {
            Caption = 'Jnl. Amount';
        }
        field(9; "Jnl. Document No."; Text[20])
        {
            Caption = 'Jnl. Document No.';
        }
        field(11; "Recipient Bank Acc. Code"; Code[50])
        {
            Caption = 'Recipient Bank Acc. No.';
        }
        field(12; "Message to Recipient"; Text[140])
        {
            Caption = 'Message to Recipient';
        }
        field(13; "Jnl. External Doc No."; Text[35])
        {
            Caption = 'Jnl. External Document No.';
        }
        field(15; "Jnl. Record ID"; RecordId)
        {

        }
    }

    keys
    {
        key(Key1; "MT101 Log Register No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PostedGnJnl: Record "Posted Gen. Journal Line";

    procedure CreateNew(RegisterNo: Integer; EntryNo: Integer; GenJnlAccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; LedgerEntryNo: Integer; JnlDate: Date; CurrencyCode: Code[10]; JnlAmount: Decimal; DocNo: Text[35]; RecipientBankAccount: Code[20]; MessageToRecipient: Text[140]; RecordIDLVar: RecordId; ExtDocNo: Code[35])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        "MT101 Log Register No." := RegisterNo;
        if EntryNo = 0 then begin
            SetRange("MT101 Log Register No.", RegisterNo);
            //LockTable();
            if FindLast then;
            "Entry No." += 1;
        end else
            "Entry No." := EntryNo;
        Init;
        GenJnlLine.Init();
        case GenJnlAccountType of
            GenJnlLine."Account Type"::Customer:
                "Account Type" := "Account Type"::Customer;
            GenJnlLine."Account Type"::Vendor:
                "Account Type" := "Account Type"::Vendor;
        end;
        "Account No." := AccountNo;
        "Applies-to Entry No." := LedgerEntryNo;
        "Jnl. Posting Date" := JnlDate;
        "Currency Code" := CurrencyCode;
        "Jnl. Amount" := JnlAmount;
        "Jnl. Document No." := DocNo;
        "Recipient Bank Acc. Code" := RecipientBankAccount;
        "Message to Recipient" := MessageToRecipient;
        "Jnl. Record ID" := RecordIDLVar;
        "Jnl. External Doc No." := ExtDocNo;
        Insert;
    end;

    procedure CreditorName(): Text
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Employee: Record Employee;
    begin
        if "Account No." = '' then
            exit('');
        case "Account Type" of
            "Account Type"::Customer:
                begin
                    if Customer.Get("Account No.") then
                        exit(Customer.Name);
                end;
            "Account Type"::Vendor:
                begin
                    if Vendor.Get("Account No.") then
                        exit(Vendor.Name);
                end;
        end;
        exit('');
    end;

    procedure GetRecipientIBANOrBankAccNo(GetIBAN: Boolean): Text
    var
        CustomerBankAccount: Record "Customer Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
        Employee: Record Employee;
    begin
        if "Account No." = '' then
            exit('');

        case "Account Type" of
            "Account Type"::Customer:
                if CustomerBankAccount.Get("Account No.", "Recipient Bank Acc. Code") then begin
                    if GetIBAN then
                        exit(CustomerBankAccount.IBAN);

                    exit(CustomerBankAccount."Bank Account No.");
                end;
            "Account Type"::Vendor:
                if VendorBankAccount.Get("Account No.", "Recipient Bank Acc. Code") then begin
                    if GetIBAN then
                        exit(VendorBankAccount.IBAN);

                    exit(VendorBankAccount."Bank Account No.");
                end;
        end;

        exit('');
    end;

    local procedure GetAppliesToEntry(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        CVLedgerEntryBuffer.Init();
        if "Applies-to Entry No." = 0 then
            exit;

        case "Account Type" of
            "Account Type"::Customer:
                begin
                    if CustLedgerEntry."Entry No." <> "Applies-to Entry No." then
                        if CustLedgerEntry.Get("Applies-to Entry No.") then
                            CustLedgerEntry.CalcFields(Amount, "Remaining Amount")
                        else
                            Clear(CustLedgerEntry);
                    CVLedgerEntryBuffer.CopyFromCustLedgEntry(CustLedgerEntry)
                end;
            "Account Type"::Vendor:
                begin
                    if VendLedgerEntry."Entry No." <> "Applies-to Entry No." then
                        if VendLedgerEntry.Get("Applies-to Entry No.") then
                            VendLedgerEntry.CalcFields(Amount, "Remaining Amount")
                        else
                            Clear(VendLedgerEntry);
                    CVLedgerEntryBuffer.CopyFromVendLedgEntry(VendLedgerEntry)
                end;
        end;
    end;

    procedure AppliesToEntryDocumentNo(): Code[20]
    var
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";
    begin
        GetAppliesToEntry(CVLedgerEntryBuffer);
        exit(CVLedgerEntryBuffer."Document No.");
    end;

    procedure AppliesToEntryDescription(): Text
    var
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";
    begin
        GetAppliesToEntry(CVLedgerEntryBuffer);
        exit(CVLedgerEntryBuffer.Description);
    end;

    procedure AppliesToEntryPostingDate(): Date
    var
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";
    begin
        GetAppliesToEntry(CVLedgerEntryBuffer);
        exit(CVLedgerEntryBuffer."Posting Date");
    end;

    procedure AppliesToEntryCurrencyCode(): Code[10]
    var
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";
    begin
        GetAppliesToEntry(CVLedgerEntryBuffer);
        exit(CVLedgerEntryBuffer."Currency Code");
    end;

    procedure AppliesToEntryAmount(): Decimal
    var
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";
    begin
        GetAppliesToEntry(CVLedgerEntryBuffer);
        exit(CVLedgerEntryBuffer.Amount);
    end;

    procedure AppliesToEntryRemainingAmount(): Decimal
    var
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";
    begin
        GetAppliesToEntry(CVLedgerEntryBuffer);
        exit(CVLedgerEntryBuffer."Remaining Amount");
    end;

    procedure AppliesToExtDocumentNo(): Code[35]
    var
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";
    begin
        GetAppliesToEntry(CVLedgerEntryBuffer);
        exit(CVLedgerEntryBuffer."External Document No.");
    end;
}

