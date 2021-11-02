tableextension 50078 VendorLedgerEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; POApproverName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; PIApproverName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "SequenceNo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Sequence No." where("Document No." = field("Document No.")));
            Caption = 'Sequence No.';
        }

    }

    var
        myInt: Integer;
}