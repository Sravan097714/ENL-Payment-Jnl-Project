page 50037 "Approval Route List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Approval Route";

    layout
    {
        area(Content)
        {
            repeater("Approval List")
            {
                field(Code; Code) { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
            }
        }
    }
}