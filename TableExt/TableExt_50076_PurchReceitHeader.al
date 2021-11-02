tableextension 50076 PurchReceiptHeader extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50014; Quantity; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Quantity';
            CalcFormula = SUM("Purch. Rcpt. Line".Quantity where("Document No." = field("No.")));

        }
    }

    var
        myInt: Integer;
}