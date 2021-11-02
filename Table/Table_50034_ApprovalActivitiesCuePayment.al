table 50034 "ApprovalActivities Cue Payment"
{
    Caption = 'Approval Entry Payment';

    DrillDownPageID = "Job Queue Entries";
    LookupPageID = "Job Queue Entries";
    ReplicateData = false;

    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(50001; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(50002; "Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Open),
                                                        "Table ID" = filter(81)));
            Caption = 'To Approve';
            FieldClass = FlowField;
        }
        field(50003; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Open),
                                                        "Table ID" = filter(81)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(50004; "Requests Rejected"; Integer)
        {
            caption = 'Rejected';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Rejected),
                                                        "Table ID" = filter(81)));
            FieldClass = FlowField;
        }
        field(50005; "Requests Cancelled"; Integer)
        {
            caption = 'Cancelled';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Canceled),
                                                        "Table ID" = filter(81)));
            FieldClass = FlowField;
        }

        field(50006; "Requests Approved"; Integer)
        {
            caption = 'Approved - UnPaid';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Approved),
                                                        "Table ID" = filter(81)));
            FieldClass = FlowField;
        }
        field(5000; "Requests Approved Posted"; Integer)
        {
            caption = 'Approved - Paid';
            CalcFormula = Count("Posted Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Approved),
                                                        "Table ID" = filter(17)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}