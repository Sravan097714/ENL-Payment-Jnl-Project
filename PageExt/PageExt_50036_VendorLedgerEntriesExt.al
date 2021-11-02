pageextension 50036 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{

    actions
    {
        addafter("Create Payment")
        {
            action("Remittance Voucher")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = PrintVoucher;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    grecVendorLedgerEntries.reset;
                    grecVendorLedgerEntries.SetRange("Document No.", rec."Document No.");
                    if grecVendorLedgerEntries.FindFirst() then begin
                        grepRemittance.SetTableView(grecVendorLedgerEntries);
                        grepRemittance.Run();
                    end;
                    //Report.run(50033, true, false, grecVendorLedgerEntries);
                end;
            }
        }
    }


    var
        grecVendorLedgerEntries: Record "Vendor Ledger Entry";
        grepRemittance: Report "Remittance Voucher Report";
}