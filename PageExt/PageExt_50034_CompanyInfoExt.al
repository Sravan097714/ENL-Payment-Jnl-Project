pageextension 50034 CompanyInfoExt extends "Company Information"
{
    layout
    {
        addafter(General)
        {
            group("MRA Reports Details")
            {
                field(BRN; BRN) { ApplicationArea = All; Editable = false; }
                field("VAT Payer Tax"; "VAT Payer Tax") { ApplicationArea = All; Editable = false; }
                field("VAT Payer Full Name"; "VAT Payer Full Name") { ApplicationArea = All; Editable = false; }
                field("Mobile Number"; "Mobile Number") { ApplicationArea = All; }
                field("Name of Declarant"; "Name of Declarant") { ApplicationArea = All; }
                field("MRA VAT Email Address"; "MRA VAT Email Address") { ApplicationArea = All; }
            }
        }
    }

}