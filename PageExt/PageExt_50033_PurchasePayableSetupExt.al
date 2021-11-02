pageextension 50033 PurchasePayableSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Threshold Goods & Services Rpt"; Rec."Threshold Goods & Services Rpt") { ApplicationArea = All; }
        }
    }
}