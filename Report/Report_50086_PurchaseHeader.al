report 50086 PurchaseHeader
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = 'Report\Layout\PurchaseHeader.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Document_Type; "Document Type") { }
            column(No_; "No.") { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Currency_Code; "Currency Code") { }
            column(Amount; Amount) { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(Posting_Description; "Posting Description") { }
            column(PO_Approved_By; "PO_Approved By") { }
            column(PI_Approved_By; "PI Approved By") { }



        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}