page 50087 History
{
    Caption = 'All';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = History;
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            cuegroup(Approvals)
            {
                Caption = 'History';
                field("Purchase Orders"; "Purchase Orders")
                {
                    ApplicationArea = Suite;
                    //Visible = false;
                    DrillDownPageID = ApprovalEntriesBasePageAppOp;
                    ToolTip = 'Specifies requests for certain documents, cards, or journal lines that your approver must approve before you can proceed.';
                }
                field("Purchase Invoices"; "Purchase Invoices")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = ApprovalEntriesBasePageAppOp;
                    ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
                }
                field("Supplier Payments"; "Supplier Payments")
                {
                    //DrillDownPageID = "Approval Entries";
                    DrillDownPageId = ApprovalEntriesBasePageAppOp;
                    ApplicationArea = All;
                }

            }
        }

    }

    actions
    {
    }


}