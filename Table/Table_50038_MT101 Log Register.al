table 50038 "MT101 Log Register"
{
    Caption = 'MT101 Log Register';
    //DataCaptionFields = "Document No.", "Created Date-Time";
    //DrillDownPageID = "MT101 Log Registers";
    //LookupPageID = "MT101 Log Registers";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
        }
        field(3; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
        }
        field(10; "Created Date-Time"; DateTime)
        {
            Caption = 'Created Date-Time';
        }
        field(11; "Created by User ID"; Code[50])
        {
            Caption = 'Created by User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }
        field(12; "Created by User Name"; Code[50])
        {
            Caption = 'Created by User Name';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."Full Name";
            ValidateTableRelation = false;
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Successful,failed';
            OptionMembers = Successful,failed;
        }
        field(14; "No. of Transfers"; Integer)
        {
            CalcFormula = Count("MT101 Log Entry" WHERE("MT101 Log Register No." = FIELD("No.")));
            Caption = 'No. of Transfers';
            FieldClass = FlowField;
        }
        /*
        field(15; "Exported File"; Media)
        {
            Caption = 'Exported File';
        }
        */
        field(18; "Storage Pointer"; Text[250])
        {
            Caption = 'Storage Pointer';
        }
        field(19; "CheckSum Storage Pointer"; Text[250])
        {
            Caption = 'CheckSum Storage Pointer';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Status)
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateNew(JnlTemplateName: Code[20]; JnlBatchName: Code[20]; FileName: Text; CheckSumFileName: Text; var MT101LogReg: Record "MT101 Log Register")
    var
        UserRec: Record User;
    begin
        Reset;
        LockTable();
        if FindLast then;
        Init;
        "No." += 1;
        "Journal Batch Name" := JnlTemplateName;
        "Journal Batch Name" := JnlBatchName;
        "Created Date-Time" := CurrentDateTime;
        "Created by User ID" := UserId;
        UserRec.Get(UserSecurityId());
        "Created by User Name" := UserRec."Full Name";
        Insert;
        MT101LogReg := Rec;
    end;
}

