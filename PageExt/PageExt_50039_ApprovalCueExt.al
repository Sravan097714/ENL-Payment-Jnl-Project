pageextension 50039 ApprovalCuePageExt extends "Approvals Activities"
{
    layout
    {
        modify("Requests Sent for Approval")
        {
            Visible = false;
        }
        addafter("Requests to Approve")
        {
            field("Requests Rejected"; "Requests Rejected")
            {
                DrillDownPageID = "ApprovalAct Entries";
                ApplicationArea = All;
            }
            field("Requests Cancelled"; "Requests Cancelled")
            {
                DrillDownPageID = "Approval Entries";
                ApplicationArea = All;
            }
        }
    }
}