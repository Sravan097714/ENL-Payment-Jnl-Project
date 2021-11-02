pageextension 50030 GenJnlBatch extends "General Journal Batches"
{
    layout
    {
        addlast(Control1)
        {
            field("MT 101"; "MT101") { ApplicationArea = All; }
        }
    }
}