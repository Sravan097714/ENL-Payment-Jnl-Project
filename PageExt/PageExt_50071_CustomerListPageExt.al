pageextension 50071 CustomerListPageExt extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Name);
        Rec.Ascending(true);
    end;


}