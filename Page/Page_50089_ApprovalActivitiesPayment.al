page 50089 "Approvals Activities Payment"
{
    Caption = 'Approval - Supplier Payments';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "ApprovalActivities Cue Payment";

    layout
    {
        area(content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Supplier Payments';
                field("Requests Sent for Approval"; "Requests Sent for Approval")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    DrillDownPageID = ApprovalEntriesDocument;
                    ToolTip = 'Specifies requests for certain documents, cards, or journal lines that your approver must approve before you can proceed.';
                }
                field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = ApprovalEntriesDocument;
                    ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
                }
                field("Requests Rejected"; "Requests Rejected")
                {
                    //DrillDownPageID = "Approval Entries";
                    DrillDownPageId = ApprovalEntriesDocument;
                    ApplicationArea = All;
                }
                field("Requests Cancelled"; "Requests Cancelled")
                {
                    //DrillDownPageID = "Approval Entries";
                    ApplicationArea = All;
                    DrillDownPageId = ApprovalEntriesDocument;
                }
                field("Requests Approved"; "Requests Approved")
                {
                    //DrillDownPageID = "Approval Entries";
                    ApplicationArea = All;
                    DrillDownPageId = ApprovalEntriesDocument;
                }
                field("Requests Approved Posted"; "Requests Approved Posted")
                {
                    //DrillDownPageID = "Approval Entries";
                    ApplicationArea = All;
                    DrillDownPageId = "Posted Approval Entries";
                }
            }
        }

    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
        SetRange("User ID Filter", UserId);
    end;
}