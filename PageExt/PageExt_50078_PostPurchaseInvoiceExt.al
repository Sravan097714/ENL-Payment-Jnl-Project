//LS
pageextension 50078 PostedPurchaseInvoiceExt extends 138
{
    layout
    {
        addlast(General)
        {
            field("Prepared By"; "Prepared By")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

    }
}