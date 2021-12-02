//LS
tableextension 50032 CustomerExt extends Customer
{
    fields
    {
        field(50000; BRN; Code[20]) { }
        field(50003; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; District; Text[30]) { }
        field(50051; Package; Text[20]) { }
        field(50052; Gender; Text[10]) { }
        field(50053; "Bank Code"; Text[10]) { }
        field(50054; "Bank Account No."; Text[30]) { }
        field(50055; "Bank Reference Code"; Text[30]) { }
        field(50056; "Bank HandShake Code"; Text[30]) { }
        field(50057; "Platform Code"; Text[20]) { }

    }
    var
        Bank: Record "Customer Bank Account";

}