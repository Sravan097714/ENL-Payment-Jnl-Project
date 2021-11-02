page 50050 "Approvals Activities Order"
{
    Caption = 'Approval - Purchase Orders';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "ApprovalActivities Cue Order";

    layout
    {
        area(content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Purchase Orders';
                field("Requests Sent for Approval"; "Requests Sent for Approval")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    DrillDownPageID = "ApprovalAct Entries";
                    ToolTip = 'Specifies requests for certain documents, cards, or journal lines that your approver must approve before you can proceed.';
                }
                field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Requests2Approve";
                    ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
                }
                field("Requests Rejected"; "Requests Rejected")
                {
                    DrillDownPageID = "ApprovalAct Entries";
                    ApplicationArea = All;
                }
                field("Requests Cancelled"; "Requests Cancelled")
                {
                    DrillDownPageID = "ApprovalAct Entries";

                    ApplicationArea = All;
                }
                field("Requests Approved"; "Requests Approved")
                {
                    DrillDownPageID = "ApprovalAct Entries";
                    ApplicationArea = All;
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