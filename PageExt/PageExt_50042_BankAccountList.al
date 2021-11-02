pageextension 50042 BankAccountList extends "Bank Account List"
{
    layout
    {
        addafter(Contact)
        {
            field(Balance; Balance)
            {
                ApplicationArea = all;
            }
            field("BankAcc. Posting Group"; "Bank Acc. Posting Group")
            {
                ApplicationArea = all;
            }
            field("Balance Last Statement"; "Balance Last Statement")
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
        bankaccountrec: Record "Bank Account";
}