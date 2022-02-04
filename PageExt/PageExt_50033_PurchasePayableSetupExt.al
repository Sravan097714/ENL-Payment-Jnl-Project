pageextension 50033 PurchasePayableSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Threshold Goods & Services Rpt"; Rec."Threshold Goods & Services Rpt") { ApplicationArea = All; }
            field("Enable Vendor Approval Rule"; Rec."Enable Vendor Approval Rule") { ApplicationArea = all; Caption = 'Enable Vendor Approval Rule For Payments'; }
        }
    }
}