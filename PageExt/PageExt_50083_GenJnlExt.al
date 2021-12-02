pageextension 50083 GenJnlExt extends 39
{
    layout
    {
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = true;
        }
        /*
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
        modify("Total Debit")
        {
            Visible = false;
        }
        modify("Total Credit")
        {
            Visible = false;
        }
        */



    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}