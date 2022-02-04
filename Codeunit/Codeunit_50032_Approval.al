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
        GenJnlTemplate: Record "Gen. Journal Template";
        CheckForBankFileExport: Boolean;
        VenApprovalErr: Label 'Approval is pending for Vendor %1 to do payments.';
        VendorRec: Record Vendor;
        PurchasePayble: Record "Purchases & Payables Setup";
    begin

        CheckForBankFileExport := GenJnlTemplate.Get(GenJournalLine."Journal Template Name") and GenJnlTemplate.MT101;
        GenJnlLineLRec.copy(GenJournalLine);
        if GenJnlLineLRec.FindSet() then
            repeat
                if PurchasePayble."Enable Vendor Approval Rule" then begin
                    if GenJnlLineLRec."Account Type" = GenJnlLineLRec."Account Type"::Vendor then begin
                        if vendorRec.Get(GenJnlLineLRec."Account No.") then begin
                            if ApprlMgt.HasOpenOrPendingApprovalEntries(vendorrec.RecordId) then
                                Error(VenApprovalErr, vendorrec."No.");
                            if not ApprlMgt.HasApprovalEntries(vendorrec.RecordId) then
                                Error(VenApprovalErr, vendorrec."No.");
                        end;
                    end else
                        if GenJnlLineLRec."Bal. Account Type" = GenJnlLineLRec."Bal. Account Type"::Vendor then begin
                            if vendorRec.Get(GenJnlLineLRec."Bal. Account No.") then begin
                                if ApprlMgt.HasOpenOrPendingApprovalEntries(vendorrec.RecordId) then
                                    Error(VenApprovalErr, vendorrec."No.");
                                if not ApprlMgt.HasApprovalEntries(vendorrec.RecordId) then
                                    Error(VenApprovalErr, vendorrec."No.");
                            end;
                        end;
                end;
                if not PreviewMode then begin
                    if ApprlMgt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJnlLineLRec) then
                        GenJnlLineLRec.TestField(Status, GenJnlLineLRec.Status::Released);
                    if CheckForBankFileExport then
                        GenJnlLineLRec.TestField("Exported to Payment File");
                end;
            until GenJnlLineLRec.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendGeneralJournalLineForApproval', '', true, true)]
    local procedure "Approvals Mgmt._OnSendGeneralJournalLineForApproval"(var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.TestField("Approval Route");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnModifyOnBeforeTestCheckPrinted', '', true, true)]
    local procedure "Gen. Journal Line_OnModifyOnBeforeTestCheckPrinted"
    (
        var GenJournalLine: Record "Gen. Journal Line";
        var IsHandled: Boolean
    )
    begin
        if GenJournalLine."Payment Method Code" = 'MT101' then
            IsHandled := true;
    end;
    /*
        [EventSubscriber(ObjectType::Report, Report::"Notification Email", 'OnSetReportFieldPlaceholdersOnAfterGetDocumentURL', '', true, true)]
        local procedure "Notification Email_OnSetReportFieldPlaceholdersOnAfterGetDocumentURL"
        (
            var DocumentURL: Text;
            var NotificationEntry: Record "Notification Entry"
        )
        var
            DataTypeManagement: Codeunit "Data Type Management";
            RecRef: RecordRef;
            TargetRecRef: RecordRef;
            PageManagement: Codeunit "Page Management";
        begin
            DataTypeManagement.GetRecordRef(NotificationEntry."Triggered By Record", RecRef);
            if RecRef.Number <> database::"Approval Entry" then
                exit;
            GetTargetRecRef(RecRef, TargetRecRef, NotificationEntry);
            if TargetRecRef.Number <> database::"Gen. Journal Line" then
                exit;
            DocumentURL := PageManagement.GetWebUrl(RecRef, 50046);
        end;

        local procedure GetTargetRecRef(RecRef: RecordRef; var TargetRecRefOut: RecordRef; NotificationEntry: Record "Notification Entry")
        var
            ApprovalEntry: Record "Approval Entry";
            OverdueApprovalEntry: Record "Overdue Approval Entry";
        begin
            case NotificationEntry.Type of
                NotificationEntry.Type::"New Record":
                    TargetRecRefOut := RecRef;
                NotificationEntry.Type::Approval:
                    begin
                        RecRef.SetTable(ApprovalEntry);
                        TargetRecRefOut.Get(ApprovalEntry."Record ID to Approve");
                    end;
                NotificationEntry.Type::Overdue:
                    begin
                        RecRef.SetTable(OverdueApprovalEntry);
                        TargetRecRefOut.Get(OverdueApprovalEntry."Record ID to Approve");
                    end;
            end;
        end;
        */
    //B2BSRA1.0 <<




}