tableextension 50038 PurchaseInvoiceHdrExt extends "Purch. Inv. Header"
{
    fields
    {
        field(50030; "Prepared By"; Text[50]) { }
    }

    trigger OnInsert()
    begin
        "Prepared By" := UserId;
    end;
}