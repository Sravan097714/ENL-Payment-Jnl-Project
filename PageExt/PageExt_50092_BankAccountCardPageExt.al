pageextension 50092 BankAccountCardPageExt extends "Bank Account Card"
{
    layout
    {
        modify("SEPA Direct Debit Exp. Format")
        {
            Visible = false;
        }
        modify("Credit Transfer Msg. Nos.")
        {
            Visible = false;
        }
        modify("Direct Debit Msg. Nos.")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Bank Clearing Standard")
        {
            Visible = false;
        }
        modify("Bank Clearing Code")
        {
            Visible = false;
        }
        modify("Payment Match Tolerance")
        {
            Visible = false;
        }
        modify("Match Tolerance Type")
        {
            Visible = false;
        }
        modify("Match Tolerance Value")
        {
            Visible = false;
        }
    }

    actions
    {
        modify("Cash Receipt Journals")
        {
            Visible = false;
        }
        modify("Payment Journals")
        {
            Visible = false;

        }

    }

    var
        myInt: Integer;
}