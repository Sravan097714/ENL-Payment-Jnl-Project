pageextension 50099 FAcardext extends "Fixed Asset Card"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            Editable = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}