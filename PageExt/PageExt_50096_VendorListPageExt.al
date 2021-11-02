pageextension 50096 VendorListPageExt extends "Vendor List"
{
    layout
    {

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Name);
        Rec.Ascending(true);
    end;
}