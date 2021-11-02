//LS
tableextension 50034 VendorExt extends Vendor
{
    fields
    {
        field(50000; BRN; Code[20]) { }
        field(50001; NID; Text[30]) { }

        field(50012; "Remittance Email"; Text[30]) { }

        field(50013; Contact2; Text[50]) { }

        field(50014; VendorBankName; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Bank Account".Name where(Code = field("Preferred Bank Account Code")));
            Caption = 'Vendor Bank Name';
        }
        field(50015; VendorBankAccountNumber; Code[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Bank Account"."Bank Account No." where(Code = field("Preferred Bank Account Code")));
        }
        field(50016; VendorBankIBAN; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Bank Account".IBAN where(Code = field("Preferred Bank Account Code")));
        }
        field(50017; VendorBankSwift; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Bank Account"."SWIFT Code" where(Code = field("Preferred Bank Account Code")));
        }
        field(50018; VBAccNum; Text[250])
        {
            FieldClass = Normal;
            Caption = 'Vendor Bank Account Number';
            Editable = false;
            TableRelation = "Vendor Bank Account"."Bank Account No.";
            ValidateTableRelation = false;
        }
        field(50019; VBAccIBAN; Text[250])
        {
            FieldClass = Normal;
            Caption = 'Vendor Bank Account IBAN';
            Editable = false;
            TableRelation = "Vendor Bank Account".IBAN;
            ValidateTableRelation = false;
        }
        field(50020; VBAccSWIFT; Text[250])
        {
            FieldClass = Normal;
            Caption = 'Vendor Bank Account IBAN';
            Editable = false;
            TableRelation = "Vendor Bank Account"."SWIFT Code";
            ValidateTableRelation = false;
        }
        field(50021; VBAccName; Text[250])
        {
            FieldClass = Normal;
            Caption = 'Vendor Bank Account Name';
            Editable = false;
            TableRelation = "Vendor Bank Account".Name;
            ValidateTableRelation = false;
        }
        field(50022; PayeeName; Text[60])
        {
            Caption = 'Payee Name';
            FieldClass = Normal;
        }


        modify("Preferred Bank Account Code")
        {
            trigger OnAfterValidate()
            var
                vendorbankaccountrec: Record "Vendor Bank Account";
            begin
                vendorbankaccountrec.SetRange(Code, "Preferred Bank Account Code");
                vendorbankaccountrec.SetRange("Vendor No.", "No.");
                if vendorbankaccountrec.FindFirst() then begin
                    VBAccName := vendorbankaccountrec.Name;
                    VBAccNum := vendorbankaccountrec."Bank Account No.";
                    VBAccIBAN := vendorbankaccountrec.IBAN;
                    VBAccSWIFT := vendorbankaccountrec."SWIFT Code";
                end
                else begin
                    VBAccName := '';
                    VBAccNum := '';
                    VBAccIBAN := '';
                    VBAccSWIFT := '';
                end;

            end;
        }

    }
}