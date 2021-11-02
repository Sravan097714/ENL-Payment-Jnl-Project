pageextension 50088 SalesInvoicePageExt extends "Sales Invoice"
{
    layout
    {
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify(Control174)
        {
            Visible = false;
        }
        modify("Direct Debit Mandate ID")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        addlast(General)
        {
            field("PostingDescription"; "Posting Description")
            {
                ShowMandatory = true;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Campaign No.")
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
        modify("Incoming Document")
        {
            Visible = false;
        }
        modify("Move Negative Lines")
        {
            Visible = false;
        }
        modify(Flow)
        {
            Visible = false;
        }
        modify("Remove From Job Queue")
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
        IsBlank: Boolean;

    trigger OnModifyRecord(): Boolean
    begin
        "Posting Description" := '';
    end;
}