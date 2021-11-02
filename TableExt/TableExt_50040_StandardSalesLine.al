tableextension 50040 StdSalesLineExt extends "Standard Sales Line"
{
    fields
    {
        field(50000; "Unit Price"; Decimal) { }
        field(50001; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
    }
}