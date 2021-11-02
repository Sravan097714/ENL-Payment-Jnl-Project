page 50051 "Vendor Approval Cue"
{
    Caption = 'Approval - Vendor';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = VendorApprovalTable;

    layout
    {
        area(content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Vendor';


                field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = Requests2Approve;
                    //ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
                }
                field("Requests Approved"; "Requests Approved")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "ApprovalAct Entries";
                    //ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
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