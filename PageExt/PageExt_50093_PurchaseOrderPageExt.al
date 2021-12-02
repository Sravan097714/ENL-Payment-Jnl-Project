pageextension 50093 PurchaseOrderPageExt extends "Purchase Order"
{
    layout
    {
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
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
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify(Prepayment)
        {
            Visible = false;
        }
    }


    actions
    {
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify(MoveNegativeLines)
        {
            Visible = false;
        }
        modify("Dr&op Shipment")
        {
            Visible = false;
        }
        modify("Speci&al Order")
        {
            Visible = false;
        }
        modify(IncomingDocument)
        {
            Visible = false;
        }
        modify(Flow)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }

    }

    var
        myInt: Integer;
}