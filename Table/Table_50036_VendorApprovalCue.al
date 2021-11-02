table 50036 "VendorApprovalTable"
{
    Caption = 'Vendor Approval';

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
                                                        "Approval Code" = filter('MS-VENDAPW**')));
            Caption = 'To Approve';
            FieldClass = FlowField;
        }
        field(50003; "Requests Approved"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Approved),
                                                        "Approval Code" = filter('MS-VENDAPW**')));
            Caption = 'Approved';
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