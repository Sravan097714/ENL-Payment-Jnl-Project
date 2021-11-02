//LS02072021
page 50038 "Closed Month"
{
    AdditionalSearchTerms = 'finance setup,general ledger setup,g/l setup';
    ApplicationArea = Basic, Suite;
    Caption = 'Closed Month';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,General,Posting,VAT,Bank,Journal Templates';
    SourceTable = "General Ledger Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Allow Posting From"; "Allow Posting From")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the earliest date on which posting to the company books is allowed.';
                }
                field("Allow Posting To"; "Allow Posting To")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the last date on which posting to the company books is allowed.';
                }


            }


        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }

    }


    trigger OnClosePage()
    var
        SessionSettings: SessionSettings;
    begin
        if IsShortcutDimensionModified then
            SessionSettings.RequestSessionUpdate(false);
    end;

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
        xGeneralLedgerSetup := Rec;
    end;

    var
        Text001: Label 'Do you want to change all open entries for every customer and vendor that are not blocked?';
        Text002: Label 'If you delete the additional reporting currency, future general ledger entries are posted in LCY only. Deleting the additional reporting currency does not affect already posted general ledger entries.\\Are you sure that you want to delete the additional reporting currency?';
        Text003: Label 'If you change the additional reporting currency, future general ledger entries are posted in the new reporting currency and in LCY. To enable the additional reporting currency, a batch job opens, and running the batch job recalculates already posted general ledger entries in the new additional reporting currency.\Entries will be deleted in the Analysis View if it is unblocked, and an update will be necessary.\\Are you sure that you want to change the additional reporting currency?';
        xGeneralLedgerSetup: Record "General Ledger Setup";

    local procedure IsShortcutDimensionModified(): Boolean
    begin
        exit(
          ("Shortcut Dimension 1 Code" <> xGeneralLedgerSetup."Shortcut Dimension 1 Code") or
          ("Shortcut Dimension 2 Code" <> xGeneralLedgerSetup."Shortcut Dimension 2 Code") or
          ("Shortcut Dimension 3 Code" <> xGeneralLedgerSetup."Shortcut Dimension 3 Code") or
          ("Shortcut Dimension 4 Code" <> xGeneralLedgerSetup."Shortcut Dimension 4 Code") or
          ("Shortcut Dimension 5 Code" <> xGeneralLedgerSetup."Shortcut Dimension 5 Code") or
          ("Shortcut Dimension 6 Code" <> xGeneralLedgerSetup."Shortcut Dimension 6 Code") or
          ("Shortcut Dimension 7 Code" <> xGeneralLedgerSetup."Shortcut Dimension 7 Code") or
          ("Shortcut Dimension 8 Code" <> xGeneralLedgerSetup."Shortcut Dimension 8 Code"));
    end;
}

