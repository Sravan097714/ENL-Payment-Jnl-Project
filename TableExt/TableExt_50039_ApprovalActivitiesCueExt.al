tableextension 50039 ApprovalActExt extends "Approvals Activities Cue"
{
    fields
    {
        field(50000; "Requests Rejected"; Integer)
        {
            caption = 'Requests Rejected';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Rejected)));
            FieldClass = FlowField;
        }
        field(50001; "Requests Cancelled"; Integer)
        {
            caption = 'Requests Cancelled';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Canceled)));
            FieldClass = FlowField;
        }
    }
}