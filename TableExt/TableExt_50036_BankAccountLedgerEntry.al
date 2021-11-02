tableextension 50036 MyExtension extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Receipt_Payment Code"; Code[20]) { }
        field(50001; "Cust/Vendor Name"; Text[100]) { }
    }
}