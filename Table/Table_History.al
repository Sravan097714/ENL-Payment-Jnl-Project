table 50065 History
{
    //DataClassification = ToBeClassified;
    /* DrillDownPageID = "Job Queue Entries";
    LookupPageID = "Job Queue Entries";
    ReplicateData = false; */

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "Purchase Orders"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = filter(38), "Document Type" = filter(Order)));
            Caption = 'Purchase Orders';
            FieldClass = FlowField;
        }
        field(50002; "Purchase Invoices"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = filter(38), "Document Type" = filter(Invoice)));
            Caption = 'Purchase Invoices';
            FieldClass = FlowField;
        }
        field(50003; "Supplier Payments"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = filter(23)));
            Caption = 'Supplier Payments';
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(Key1; MyField)
        {
            Clustered = true;
        }
    }


}