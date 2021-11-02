tableextension 50077 ApprovalEntryExt extends "Approval Entry"
{
    fields
    {
        field(50000; ApproverName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; SenderName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sender-Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Approver-Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}