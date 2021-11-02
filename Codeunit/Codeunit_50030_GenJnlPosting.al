codeunit 50030 "Gen Jnl Posting"
{
    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure InsertinBankAccLedgerEntry(VAR BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Dimension: array[8] of Code[20];
    begin
        GenJournalLine.ShowShortcutDimCode(Dimension);
        BankAccountLedgerEntry."Receipt_Payment Code" := Dimension[3];
    end;


    [EventSubscriber(ObjectType::Table, 172, 'OnBeforeApplyStdCodesToSalesLines', '', false, false)]
    local procedure OnBeforeApplyStdCodesToSalesLines(var SalesLine: Record "Sales Line"; StdSalesLine: Record "Standard Sales Line")
    begin
        SalesLine.Validate("Unit Price", StdSalesLine."Unit Price");
        SalesLine.Validate("VAT Prod. Posting Group", StdSalesLine."VAT Prod. Posting Group");
        SalesLine.Validate("Description 2", StdSalesLine.Description);
    end;


    [EventSubscriber(ObjectType::Codeunit, 232, 'OnAfterPostJournalBatch', '', false, false)]
    local procedure OnAfterPostJournalBatch(var GenJournalLine: Record "Gen. Journal Line");
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        GLReg2: Record "G/L Register";
        GLReg: Record "G/L Register";
        grecPurchPayableSetup: Record "Purchases & Payables Setup";
        greport50036: Report 50036;
    begin
        grecPurchPayableSetup.Get();
        if gtextAccountType = 'Bank Account' then begin
            with GenJournalLine do begin
                IF GLReg.GET("Line No.") THEN BEGIN
                    IF GLReg."Source Code" = 'GENJNL' THEN begin
                        BankAccountLedgerEntry.RESET;
                        BankAccountLedgerEntry.SETRANGE("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                        IF BankAccountLedgerEntry.FINDSET THEN begin
                            //REPORT.Run(grecPurchPayableSetup."Bank Transfer Report ID", false, false, BankAccountLedgerEntry);
                            REPORT.Run(50034, false, false, BankAccountLedgerEntry);
                        end;
                    end;
                end;
            end;
            gtextAccountType := '';
            Message('The journal lines were successfully posted.');
            Error('');
        end;

        if (gtextAccountType = 'Vendor') and (gtextPaymentMethod = 'CHECK') then begin
            with GenJournalLine do begin
                IF GLReg.GET("Line No.") THEN BEGIN
                    IF GLReg."Source Code" = 'PAYMENTJNL' THEN begin
                        GLReg2.RESET;
                        GLReg2.SETRANGE("From Entry No.", GLReg."From Entry No.");
                        GLReg2.SetRange("To Entry No.", GLReg."To Entry No.");
                        IF GLReg2.FINDSET THEN begin
                            //REPORT.Run(grecPurchPayableSetup."Vendor Cheque Trans. Report ID", false, false, GLReg2);
                            REPORT.Run(50036, false, false, GLReg2);
                        end;
                    end;
                end;
                gtextAccountType := '';
                gtextPaymentMethod := '';
                Message('The journal lines were successfully posted.');
                Error('');
            end;
        end;

        if (gtextAccountType = 'Vendor') and (gtextPaymentMethod = 'BANKTRANS') then begin
            with GenJournalLine do begin
                IF GLReg.GET("Line No.") THEN BEGIN
                    IF GLReg."Source Code" = 'PAYMENTJNL' THEN begin
                        VendorLedgerEntry.RESET;
                        VendorLedgerEntry.SETRANGE("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                        IF VendorLedgerEntry.FINDSET THEN begin

                            GLReg2.RESET;
                            GLReg2.SETRANGE("From Entry No.", GLReg."From Entry No.");
                            GLReg2.SetRange("To Entry No.", GLReg."To Entry No.");
                            IF GLReg2.FINDSET THEN begin
                                //REPORT.Run(50036, false, false, GLReg2);
                                greport50036.SetTableView(GLReg2);
                                greport50036.UseRequestPage(false);
                                greport50036.Run;
                            end;
                            REPORT.Run(50035, false, false, VendorLedgerEntry);
                        end;
                    end;
                end;
            end;
            gtextAccountType := '';
            gtextPaymentMethod := '';
            Message('The journal lines were successfully posted.');
            Error('');
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 232, 'OnBeforePostJournalBatch', '', false, false)]
    local procedure OnBeforePostJournalBatch(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    begin
        gtextAccountType := Format(GenJournalLine."Account Type");
        gtextPaymentMethod := GenJournalLine."Payment Method Code";
    end;

    /* [EventSubscriber(ObjectType::Table, 81, 'OnExportPaymentFileOnBeforeRunExport', '', false, false)]
    local procedure OnExportPaymentFileOnBeforeRunExport(var GenJournalLine: Record "Gen. Journal Line")
    var
        gcuMT101Generator: Codeunit "MT101 Generator";
        grecGenJnlLine: Record "Gen. Journal Line";
    begin
        grecGenJnlLine.Reset();
        grecGenJnlLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        grecGenJnlLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        if grecGenJnlLine.Findset() then begin
            Message(format(grecGenJnlLine.Count));
            gcuMT101Generator.GenrateMT101File(grecGenJnlLine);
            Error('');
        end;
    end; */

    var
        gcodePVNumber: Code[20];
        gtextAccountType: Text;
        gtextPaymentMethod: Text;
}