//LS
pageextension 50032 CustomerCardExt extends "Customer Card"
{
    layout
    {

        modify(GLN)
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Service Zone Code")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        modify("Copy Sell-to Addr. to Qte From")
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
        modify("Prepayment %")
        {
            visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Reminder Terms Code")
        {
            Visible = false;
        }
        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("No.")
        {
            Editable = false;
        }


    }
    actions
    {
        modify(NewReminder)
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify("&Jobs")
        {
            Visible = false;
        }
        modify("Cross Re&ferences")
        {
            Visible = false;
        }
        modify(NewBlanketSalesOrder)
        {
            Visible = false;
        }
        modify(NewSalesQuote)
        {
            Visible = false;
        }
        modify(NewServiceQuote)
        {
            Visible = false;
        }
        modify(NewServiceInvoice)
        {
            Visible = false;
        }
        modify(NewServiceOrder)
        {
            Visible = false;

        }
        modify(NewServiceCreditMemo)
        {
            Visible = false;
        }
        modify(NewFinanceChargeMemo)
        {
            Visible = false;
        }
        modify(Flow)
        {
            Visible = false;
        }
        modify("Post Cash Receipts")
        {
            Visible = false;
        }
        modify("Sales Journal")
        {
            Visible = false;
        }
        modify(PaymentRegistration)
        {
            Visible = false;
        }
        modify("Direct Debit Mandates")
        {
            Visible = false;
        }
        modify(ShipToAddresses)
        {
            Visible = false;
        }
        modify("Issued Documents")
        {
            Visible = false;

        }
        modify("Entry Statistics")
        {
            Visible = false;

        }
        modify("Statistics by C&urrencies")
        {
            Visible = false;
        }
        modify("Item &Tracking Entries")
        {
            Visible = false;
        }
        modify("Prepa&yment Percentages")
        {
            Visible = false;
        }
        modify(Quotes)
        {
            Visible = false;
        }
        modify("Return Orders")
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify("Blanket Orders")
        {
            Visible = false;
        }
        /* modify(CustomerReportSelections)
        {
            Visible = false;
        } */
        modify(BackgroundStatement)
        {
            Visible = false;
        }


    }
    var
        customerrec: Record Customer;
}