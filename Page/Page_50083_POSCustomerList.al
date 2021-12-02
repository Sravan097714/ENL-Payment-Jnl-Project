page 50083 "POS Customer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Name 2"; Rec."Name 2") { ApplicationArea = all; }
                field(Address; Rec.Address) { ApplicationArea = all; }
                field("Address 2"; Rec."Address 2") { ApplicationArea = all; }
                field("Date Of Birth"; Rec."Date Of Birth") { ApplicationArea = all; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = all; }
                field("Mobile Phone No."; Rec."Mobile Phone No.") { ApplicationArea = all; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = all; }
                field(District; Rec.District) { ApplicationArea = all; }
                field(Package; Rec.Package) { ApplicationArea = all; }
                field("Bank Code"; Rec."Bank Code") { ApplicationArea = all; }
                field("Bank Account No."; Rec."Bank Account No.") { ApplicationArea = all; }
                field("Bank HandShake Code"; Rec."Bank HandShake Code") { ApplicationArea = all; }
                field("Bank Reference Code"; Rec."Bank Reference Code") { ApplicationArea = all; }
                field("Platform Code"; Rec."Platform Code") { ApplicationArea = all; }
            }
        }
    }
}