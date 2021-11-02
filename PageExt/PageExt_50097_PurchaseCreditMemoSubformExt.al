//LS02072021--
pageextension 50097 PurchaseCreditMemoSubformExt extends 98
{
    layout
    {
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter("VAT Prod. Posting Group")
        {
            field("Gen.Prod. Posting Group"; "Gen. Prod. Posting Group")
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
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}