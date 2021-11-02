codeunit 50032 ApprovalENL
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 256 then
            PageID := 50030;
    end;

    [EventSubscriber(ObjectType::Page, 233, 'OnSetVendApplIdOnAfterCheckAgainstApplnCurrency', '', false, false)]
    local procedure OnSetVendApplIdOnAfterCheckAgainstApplnCurrency(var VendorLedgerEntry: Record "Vendor Ledger Entry"; CalcType: Option Direct,GenJnlLine,PurchHeader; GenJnlLine: Record "Gen. Journal Line")

    begin
        if GenJnlLine.Status <> GenJnlLine.Status::Open then
            Error('Payment Journal already sent for approval.');

    end;
    //B2BSRA1.0 >>
    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', true, true)]
    local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        ApprovalEntry: Record "Approval Entry";
        AprvlMgt: Codeunit "Approvals Mgmt.";
    begin
        CASE RecRef.NUMBER OF
            DATABASE::"Gen. Journal Line":
                begin
                    RecRef.SetTable(GenJnlLine);
                    GenJnlLine.Status := GenJnlLine.Status::Released;
                    GenJnlLine."Last ApproverID" := UserId;
                    GenJnlLine.Modify;
                    Handled := true;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', true, true)]
    local procedure OpenTransDocument(RecRef: RecordRef; VAR Handled: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        ApprovalEntry: Record "Approval Entry";
    begin
        CASE RecRef.NUMBER OF
            DATABASE::"Gen. Journal Line":
                begin
                    RecRef.SetTable(GenJnlLine);
                    GenJnlLine.Status := GenJnlLine.Status::Open;
                    GenJnlLine."Last ApproverID" := UserId;
                    GenJnlLine.Modify;
                    Handled := true;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure PendingTranDocument(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        AprvlMgt: Codeunit "Approvals Mgmt.";
    begin
        CASE RecRef.Number OF
            DATABASE::"Gen. Journal Line":
                begin
                    RecRef.SetTable(GenJnlLine);
                    GenJnlLine.Status := GenJnlLine.Status::"Pending Approval";
                    GenJnlLine."Last ApproverID" := UserId;
                    GenJnlLine.Modify;
                    IsHandled := true;
                end;
        end;
    end;
    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', true, true)]
        local procedure "Gen. Jnl.-Post_OnBeforeCode"(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
        var
            GenJnlLineLRec: Record "Gen. Journal Line";
            ApprlMgt: Codeunit "Approvals Mgmt.";
        begin
            GenJnlLineLRec.copy(GenJournalLine);
            if GenJnlLineLRec.FindSet() then
                repeat
                    if ApprlMgt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJnlLineLRec) then
                        GenJnlLineLRec.TestField(Status, GenJnlLineLRec.Status::Released);
                until GenJnlLineLRec.Next() = 0;
        end;
    */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforeCode', '', true, true)]
    local procedure "Gen. Jnl.-Post Batch_OnBeforeCode"(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean; CommitIsSuppressed: Boolean)
    var
        GenJnlLineLRec: Record "Gen. Journal Line";
        ApprlMgt: Codeunit "Approvals Mgmt.";
    begin
        if PreviewMode then
            exit;
        GenJnlLineLRec.copy(GenJournalLine);
        if GenJnlLineLRec.FindSet() then
            repeat
                if ApprlMgt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJnlLineLRec) then
                    GenJnlLineLRec.TestField(Status, GenJnlLineLRec.Status::Released);
            until GenJnlLineLRec.Next() = 0;
    end;

    //B2BSRA1.0 <<




}