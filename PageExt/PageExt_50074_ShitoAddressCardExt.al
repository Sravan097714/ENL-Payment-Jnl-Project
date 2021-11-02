pageextension 50074 ShiptoAddressCardExt extends 300
{
    layout
    {
        modify(Name)
        {
            Caption = 'Project Name';
        }
        modify(Address)
        {
            Caption = 'Block';
        }
        modify("Address 2")
        {
            Caption = 'VEFA Price';
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}