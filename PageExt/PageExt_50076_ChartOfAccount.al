pageextension 50076 ChartofAccountExt extends "Chart of Accounts"
{
    layout
    {
        addlast(Control1)
        {
            field("Global Dimension 1 Code"; "Global Dimension 1 Code") { ApplicationArea = all; }
            field("Global Dimension 2 Code"; "Global Dimension 2 Code") { ApplicationArea = all; }
        }
    }
}