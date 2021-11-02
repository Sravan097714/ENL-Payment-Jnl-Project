pageextension 50100 FixedAssetGLJournalExt extends "Fixed Asset G/L Journal"
{
    layout
    {
        modify("Number of Lines")
        {
            Visible = false;
        }
        modify(Control1902759701)
        {
            Visible = false;
        }
        modify("Total Balance")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}