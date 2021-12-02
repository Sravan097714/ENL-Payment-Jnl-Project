page 50049 "MT101 Log Reg. Entries"
{
    Caption = 'MT101 Log Reg. Entries';
    Editable = false;
    PageType = List;
    SourceTable = "MT101 Log Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field(CreditorName; Rec.CreditorName)
                {
                    ApplicationArea = All;
                    Caption = 'Recipient Name';
                }
                field(RecipientIBAN; Rec.GetRecipientIBANOrBankAccNo(true))
                {
                    ApplicationArea = All;
                    Caption = 'Recipient IBAN';
                    Visible = false;
                }
                field("GetRecipientIBANOrBankAccNo(FALSE)"; Rec.GetRecipientIBANOrBankAccNo(false))
                {
                    ApplicationArea = All;
                    Caption = 'Recipient Bank Acc. No.';
                }

                field("Jnl. Posting Date"; Rec."Jnl. Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Jnl. Amount"; Rec."Jnl. Amount")
                {
                    ApplicationArea = All;
                }
                field("Jnl. Document No."; Rec."Jnl. Document No.")
                {
                    ApplicationArea = All;
                }
                field("Message to Recipient"; Rec."Message to Recipient")
                {
                    ApplicationArea = All;
                    Caption = 'Message to Recipient';
                }
                field("Applies-to Entry No."; Rec."Applies-to Entry No.")
                {
                    ApplicationArea = All;
                }
                field(AppliesToEntryDocumentNo; Rec.AppliesToEntryDocumentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Applies-to Entry Document No.';
                }
                field(AppliesToExtDocumentNo; Rec.AppliesToExtDocumentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Applies-to Entry External Document No.';
                }
                field(AppliesToEntryPostingDate; Rec.AppliesToEntryPostingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Applies-to Entry Posting Date';
                }
                field(AppliesToEntryDescription; Rec.AppliesToEntryDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Applies-to Entry Description';
                }
                field(AppliesToEntryCurrencyCode; Rec.AppliesToEntryCurrencyCode)
                {
                    ApplicationArea = All;
                    Caption = 'Applies-to Entry Currency Code';
                }
                field(AppliesToEntryAmount; Rec.AppliesToEntryAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Applies-to Entry Amount';
                }
                field(AppliesToEntryRemainingAmount; Rec.AppliesToEntryRemainingAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Applies-to Entry Remaining Amount';
                }
                field("MT101 Log Register No."; Rec."MT101 Log Register No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

