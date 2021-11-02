pageextension 50075 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = false;
        }
        modify(Description)
        {
            Caption = 'G/L Account Name';
        }
        moveafter(Description; "VAT Prod. Posting Group")
        addbefore("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                Caption = 'Description';
                ApplicationArea = all;
            }
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }


    }
}