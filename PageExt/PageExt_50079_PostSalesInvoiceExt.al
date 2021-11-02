//LS
pageextension 50079 PostSalesInvoiceExt extends 132
{
    layout
    {
        addlast(General)
        {
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

    }


}