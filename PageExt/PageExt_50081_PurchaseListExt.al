//LS
pageextension 50081 PurchaselistExt extends 53
{    
    
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = all;
            }
            field("Amount Including VAT"; "Amount Including VAT")
            {
                ApplicationArea = all;
            }
        }
    }


}