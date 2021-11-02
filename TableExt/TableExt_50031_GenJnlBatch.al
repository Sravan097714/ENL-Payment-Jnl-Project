tableextension 50031 GenJnlBatchExt extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; "Batch Created By"; Text[50]) { }
        field(50001; "MT101"; Boolean) { }
    }

    /* trigger OnInsert()
    begin
        "Batch Created By" := UserId;
        Date := Today;
    end; */
}