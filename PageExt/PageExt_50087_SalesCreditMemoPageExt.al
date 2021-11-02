pageextension 50087 SalesCreditMemoPageExt extends "Sales Credit Memo"
{
    layout
    {
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            ShowMandatory = true;
            Visible = false;
        }
        addlast(General)
        {
            field("PostingDescription"; "Posting Description")
            {
                ShowMandatory = true;
                ApplicationArea = all;

            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = false;
        }
        modify("Applies-to ID")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }



    }

    actions
    {
        modify(GetStdCustSalesCodes)
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
        IsBlank: Boolean;
}