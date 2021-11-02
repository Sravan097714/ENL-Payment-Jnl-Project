pageextension 50091 PurchaseCreditMemoPageExt extends 52
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
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
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify(Application)
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
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Caption = 'Department Approver';
        }

    }

    actions
    {
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify("Move Negative Lines")
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
    }

    var
        myInt: Integer;
        IsBlank: Boolean;
}