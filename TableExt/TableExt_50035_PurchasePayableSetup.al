tableextension 50035 PurchasePayableSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Threshold Goods & Services Rpt"; Decimal) { }
        field(50001; "Enable Vendor Approval Rule"; Boolean) { Caption = 'Enable Vendor approval rule for payment.'; }
    }
}