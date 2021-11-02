table 50035 "ApprovalActivities Cue Order"
{
    Caption = 'Approval Entry Order';

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
                                                        "Document Type" = filter(Order),
                                                        "Table ID" = filter(38)));
            Caption = 'To Approve';
            FieldClass = FlowField;
        }
        field(50003; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Open),
                                                        "Document Type" = filter(Order),
                                                        "Table ID" = filter(38)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(50004; "Requests Rejected"; Integer)
        {
            caption = 'Rejected';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Rejected),
                                                        "Document Type" = filter(Order),
                                                        "Table ID" = filter(38)));
            FieldClass = FlowField;
        }
        field(50005; "Requests Cancelled"; Integer)
        {
            caption = 'Cancelled';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Canceled),
                                                        "Document Type" = filter(Order),
                                                        "Table ID" = filter(38)));
            FieldClass = FlowField;
        }
        field(50006; "Requests Approved"; Integer)
        {
            caption = 'Approved - UnPosted';
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Approved),
                                                        "Document Type" = filter(Order),
                                                        "Table ID" = filter(38)));
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