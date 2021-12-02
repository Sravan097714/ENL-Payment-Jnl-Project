page 50048 "MT101 Log Registers"
{
    ApplicationArea = all;
    Caption = 'MT101 Log Registers';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "MT101 Log Register";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("FORMAT(""Created Date-Time"")"; Format(Rec."Created Date-Time"))
                {
                    ApplicationArea = All;
                    Caption = 'Created Date-Time';
                }
                field("Created by User ID"; Rec."Created by User ID")
                {
                    ApplicationArea = All;
                }
                field("Created by User Name"; Rec."Created by User Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. of Transfers"; Rec."No. of Transfers")
                {
                    ApplicationArea = All;
                }
                field("Storage Pointer"; Rec."Storage Pointer")
                {
                    ApplicationArea = all;
                }
                field("CheckSum Storage Pointer"; Rec."CheckSum Storage Pointer")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = Notes;
            }
            systempart(Control10; Links)
            {
                ApplicationArea = RecordLinks;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Entries)
            {
                ApplicationArea = All;
                Caption = 'Entries';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "MT101 Log Reg. Entries";
                RunPageLink = "MT101 Log Register No." = FIELD("No.");
            }
        }
    }
}

