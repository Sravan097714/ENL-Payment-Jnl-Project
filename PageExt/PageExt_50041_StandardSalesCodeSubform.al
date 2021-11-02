pageextension 50041 StdSalesCodeSubExt extends "Standard Sales Code Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Unit Price"; "Unit Price") { ApplicationArea = All; }
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group") { ApplicationArea = All; }
        }
    }
}