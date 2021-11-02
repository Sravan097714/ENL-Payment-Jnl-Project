pageextension 50035 BanklAccLedgerEntriesExt extends "Bank Account Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Receipt_Payment Code"; "Receipt_Payment Code") { ApplicationArea = All; }
        }
        addafter("Bank Account No.")
        {
            field("Bal.Account Type"; "Bal. Account Type")
            {
                ApplicationArea = all;
            }
            field("Bal.Account No."; "Bal. Account No.")
            {
                ApplicationArea = all;
            }
            field("Cust/Vendor Name"; "Cust/Vendor Name")
            {
                ApplicationArea = all;
            }
        }
        addafter("Document No.")
        {
            field("External Document No."; "External Document No.")
            {
                ApplicationArea = all;
            }
        }

    }
    trigger OnAfterGetRecord()
    var
        vendorrec: Record Vendor;
        customerrec: Record Customer;
    begin
        vendorrec.Reset();
        customerrec.Reset();

        if "Bal. Account Type" = "Bal. Account Type"::Vendor then begin
            vendorrec.SetRange("No.", "Bal. Account No.");
            if vendorrec.FindFirst then
                "Cust/Vendor Name" := vendorrec.Name;
        end;

        if "Bal. Account Type" = "Bal. Account Type"::Customer then begin
            customerrec.SetRange("No.", "Bal. Account No.");
            if customerrec.FindFirst then
                "Cust/Vendor Name" := customerrec.Name;

        end;
    end;
}