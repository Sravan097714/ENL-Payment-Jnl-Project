//LS02072021-
pageextension 50098 SalesCreditMemoSubformExt extends 96
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
        addafter(Description)
        {
            field("Description 2"; "Description 2") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}