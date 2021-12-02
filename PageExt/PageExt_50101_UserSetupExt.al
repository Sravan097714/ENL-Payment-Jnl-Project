pageextension 50101 UserSetupExt extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(PhoneNo)
        {
            field("Access To Export MT101"; "Access To Export MT101")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}