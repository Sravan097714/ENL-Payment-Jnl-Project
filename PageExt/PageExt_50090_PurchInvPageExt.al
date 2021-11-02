pageextension 50090 PurchInvPageExt extends 51
{
    layout
    {
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
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
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Vendor Invoice No.")
        {
            ApplicationArea = all;
        }
        modify("Posting Date")
        {
            ShowMandatory = true;
        }
        modify("Posting Description")
        {
            ShowMandatory = true;
        }


    }

    actions
    {
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify(IncomingDocument)
        {
            Visible = false;
        }
        modify("F&unctions")
        {
            Visible = false;
        }
        modify(Flow)
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
}