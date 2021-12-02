pageextension 50068 GenJnlTemplate extends "General Journal Templates"
{
    layout
    {
        // Add changes to page layout here
        addafter("Copy to Posted Jnl. Lines")
        {
            field(MT101; Rec.MT101)
            {
                ApplicationArea = all;
            }
        }
        modify("Page ID")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}