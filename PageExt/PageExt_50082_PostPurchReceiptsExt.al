//LS
pageextension 50082 PostPurchReceipts extends 145
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {

            field(Quantity; Quantity)
            {
                ApplicationArea = all;
            }
        }
    }




}