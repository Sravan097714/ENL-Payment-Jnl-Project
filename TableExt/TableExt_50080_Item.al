tableextension 50079 Item extends Item
{
    fields
    {
        field(50030; Discount; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount';
        }
        field(50031; "Level 2 Categorization"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Assiette","Hot Beverage","Cake","Ice Cream","Soft Drinks","Water","Juice","Ice","Viennoiserie","Snacks","Sports","Meeting Rooms";
            Caption = 'Level 2 Categorization';

        }
    }

    var
        myInt: Integer;
}