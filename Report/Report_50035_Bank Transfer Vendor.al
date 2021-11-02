report 50035 "Bank Transfer Vendor"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\Bank Transfer Reportvendor.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {

        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Document No.";

            column(BankLetterFor; BankLetterFor) { }

            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Footer1; CompanyInfo."VAT Payer Tax") { }
            column(Footer2; CompanyInfo.BRN) { }
            column(Footer3; CompanyInfo."VAT Payer Full Name") { }
            column(Footer4; CompanyInfo."Phone No.") { }
            column(Footer5; CompanyInfo."Mobile Number") { }
            column(BankName; BankName) { }
            column(BankAddress; BankAddress) { }
            column(BankAddress2; BankAddress2) { }
            column(BankCity; BankCity) { }
            column(BankAccNo; BankAccount."Bank Account No.") { }
            column(BankAcc_IBAN; BankAccount.IBAN) { }
            column(BankAcc_SwiftCode; BankAccount."SWIFT Code") { }
            column(GenJnlLine_Comment; GenJnlLine.Comment) { }
            column(BankAcc_CurrencyCode; BankAccount."Currency Code") { }
            column(BankAccName; BankAccName) { }
            column(VendorSwiftCode; VendorSwiftCode) { }
            column(VendorIBAN; VendorIBAN) { }
            column(BankSwiftCode; BankSwiftCode) { }
            column(BankIBAN; BankIBAN) { }
            column(BankAccountName; BankAccountName) { }
            column(CurrCode; CurrCode) { }
            column(PostingDate; "Posting Date") { }
            column(CurrencyCode; "Currency Code") { }
            column(CurrentAccNo; Description) { }
            column(VendorAccNo; VendorAccNo) { }
            column(AmountInWords; TextInWords[1] + '  ' + TextInWords[2]) { }
            column(NoText; TextInWords[1]) { }
            column(Amt; Amt) { }
            column(Add1; Add1) { }
            column(add2; add2) { }
            column(city; city) { }
            column(vendorname; vendorname) { }

            column(DocNoCaption; DocNoCaption)
            {
                Caption = 'Document No';
            }
            column(DocTypeCaption; DocTypeCaption)
            {
                Caption = 'Document Type';
            }
            column(PostingDateCaption; PostingDateCaption)
            {
                Caption = 'Posting Date';
            }
            column(DescCaption; DescCaption)
            {
                Caption = 'Description';
            }
            column(MessageToRecipient; "Vendor Ledger Entry"."Message to Recipient") { }
            column(AmtCaption; AmtCaption)
            {
                Caption = 'Amount';
            }
            column(DocumentNo; "Vendor Ledger Entry"."Document No.") { }
            column(BankLetterSign; Signature[1]) { }
            column(BankLetterSign1; Signature[2]) { }
            column(BankLetterSignTitle; Signature[3]) { }
            column(BankLetterSignTitle1; Signature[4]) { }

            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = where("Entry Type" = filter('Application'), "Initial Document Type" = filter('Invoice'));
                column(Amt_VLE; Amount) { }
                dataitem("Vendor Ledger Entry2"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");

                    column(VLE_DT; "Vendor Ledger Entry2"."Document Type") { }
                    column(VLE_DN; "Vendor Ledger Entry2"."Document No.") { }
                    column(VLE_PD; FORMAT("Vendor Ledger Entry2"."Posting Date")) { }
                    column(Desc_VLE; "Vendor Ledger Entry2".Description) { }
                    //column(Amt_VLE; "Vendor Ledger Entry2"."Credit Amount") { }
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
                    IF BankAccount.GET("Bal. Account No.") THEN
                        BankAccName := BankAccount."Bank Account No." + ' ' + '(' + BankAccount.Name + ')';
                    BankSwiftCode := BankAccount."SWIFT Code";
                    BankIBAN := BankAccount.IBAN;
                    BankAccountName := BankAccount.Name;
                    BankAddress := BankAccount.Address;
                    BankAddress2 := BankAccount."Address 2";
                    BankCity := BankAccount.City;
                END;

                VendorBankAccount.RESET;
                VendorBankAccount.SETRANGE("Vendor No.", "Vendor No.");
                IF VendorBankAccount.FINDFIRST THEN BEGIN
                    VendorAccNo := VendorBankAccount."Bank Account No." + ' ' + '(' + VendorBankAccount.Name + ')';
                    VendorSwiftCode := VendorBankAccount."SWIFT Code";
                    VendorIBAN := VendorBankAccount.IBAN;
                END;

                "Vendor Ledger Entry".CALCFIELDS(Amount);
                Amt := ROUND(Amount, 0.01);
                Check.InitTextVariable;
                Check.FormatNoText(TextInWords, Amount, '');

                IF "Vendor Ledger Entry"."Currency Code" <> '' THEN
                    CurrCode := COPYSTR("Vendor Ledger Entry"."Currency Code", 1, 3)
                ELSE
                    CurrCode := 'MUR';

                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Bal. Account No.", BankAccount."No.");
                IF GenJnlLine.FINDFIRST THEN BEGIN
                    Comment := GenJnlLine."Message to Recipient";
                END;

                Vendor.Reset();
                Vendor.SetRange("No.", "Vendor No.");
                if Vendor.FindFirst() then begin
                    Add1 := Vendor.Address;
                    add2 := Vendor."Address 2";
                    city := Vendor.City;
                    vendorname := Vendor.Name;

                end;

            end;

            trigger OnPreDataItem()
            begin
                BankLetterFor := 'Vendor Payment/Transfer';
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        /*
        IF CompanyInfo.Print1 THEN BEGIN
          Signature[1] := CompanyInfo."E-mail Payer";
          Signature[3] := CompanyInfo."Bank Letter Sign Title";
        END;
        
        IF CompanyInfo.Print2 THEN BEGIN
          IF (Signature[1] = '') THEN BEGIN
            Signature[1] := CompanyInfo."Bank Letter Sign 1";
            Signature[3] := CompanyInfo."Bank Letter Sign 1 Title";
          END ELSE BEGIN
            Signature[2] := CompanyInfo."Bank Letter Sign 1";
            Signature[4] := CompanyInfo."Bank Letter Sign 1 Title";
          END;
        END;
        
        IF CompanyInfo.Print3 THEN BEGIN
          IF Signature[1] = '' THEN BEGIN
            Signature[1] := CompanyInfo."Business Registration No.";
            Signature[3] := CompanyInfo."Bank Address";
          END ELSE BEGIN
            Signature[2] := CompanyInfo."Business Registration No.";
            Signature[4] := CompanyInfo."Bank Address";
          END;
        END;
        
        IF CompanyInfo.Print4 THEN BEGIN
          Signature[2] := CompanyInfo."Bank Address 2";
          Signature[4] := CompanyInfo."Bank City";
        END;
        */
    end;

    var
        BankAccount: Record 270;
        Check: Report 50037;
        TextInWords: array[2] of Text;
        Amt: Decimal;
        CompanyInfo: Record 79;
        BankAccName: Text[250];
        BankAccountName: Text[250];
        Vendor: Record 23;
        CurrentAccNo: Text[250];
        BankLetterFor: Text[250];
        VendorAccNo: Text[250];
        PostingDateCaption: Label 'Posting Date';
        DocNoCaption: Label 'Document No.';
        DocTypeCaption: Label 'Document Type';
        DescCaption: Label 'Description';
        AmtCaption: Label 'Amount';
        Language: Record 8;
        Vendor2: Record 23;
        CurrCode: Text;
        VendorBankAccount: Record 288;
        VendorSwiftCode: Text[250];
        VendorIBAN: Text[250];
        BankSwiftCode: Text[250];
        BankIBAN: Text[250];
        GenJnlLine: Record 81;
        Comment: Text[250];

        Add1: Text[250];
        add2: Text[250];
        city: Text[50];
        Signature: array[4] of Text;
        BankName: Text[100];
        BankAddress: Text[200];
        BankAddress2: Text[200];

        BankCity: Text[200];
        vendorname: Text[100];
}

