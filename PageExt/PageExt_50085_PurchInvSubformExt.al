pageextension 50085 PurchInvSubform extends 55
{
    layout
    {

        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        //LS02072021--
        modify("Line Discount %")
        {
            Visible = false;
        }
        addafter("Unit of Measure")
        {
            field("VATProd. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = false;
        }






    }

    actions
    {
        /*  modify(GetReceiptLines)
          {
              Visible = false;
              PromotedCategory = to test;
          }


          */
    }

    var
        myInt: Integer;
}