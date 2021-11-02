pageextension 50040 RequestToApproveExt extends "Requests to Approve"
{
    layout
    {
        movelast(Control1; Details, Comment)
        addafter("Currency Code")
        {
            field(GtextDescription; GtextDescription)
            {
                ApplicationArea = all;
                Caption = 'Description';
            }
        }
        addafter("Sender ID")
        {
            field(SenderName; "Sender-Name") { ApplicationArea = all; }
            field("Date-Time Sent for Approval"; "Date-Time Sent for Approval")
            {
                ApplicationArea = all;
            }
            field(ApproverName; "Approver-Name") { ApplicationArea = all; }
        }
        modify("Sender ID") { Visible = false; }





    }

    trigger OnAfterGetRecord()
    var
        genjourlinerec: Record "Gen. Journal Line";
        userrec: Record User;
    begin
        Clear(GtextDescription);
        genjourlinerec.Reset();
        genjourlinerec.SetRange("Document No.", "Document No.");
        if genjourlinerec.FindFirst then
            GtextDescription := genjourlinerec.Description;

        userrec.Reset();
        userrec.SetRange("User Name", "Approver ID");
        if userrec.FindFirst then
            "Approver-Name" := userrec."Full Name";

        userrec.Reset();
        userrec.SetRange("User Name", "Sender ID");
        if userrec.FindFirst then
            "Sender-Name" := userrec."Full Name";

    end;

    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetRange("Approver ID");
        FilterGroup(0);
        SetRange(Status);
    end;

    var
        GtextDescription: Text;
}