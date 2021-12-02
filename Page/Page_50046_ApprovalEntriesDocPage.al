page 50046 "ApprovalEntriesDocument"
{
    ApplicationArea = all;
    Caption = 'ApprovalEntriesDoc';
    Editable = false;
    PageType = Document;
    SourceTable = "Approval Entry";
    SourceTableView = SORTING("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval")
                      ORDER(Ascending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Document No."; "Document No.")
                {
                    ApplicationArea = Suite;
                    //Visible = false;
                    ToolTip = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.';
                    StyleExpr = StyleTxt;
                }
                field(PaymentMethodCodeGVar; PaymentMethodCodeGVar)
                {
                    ApplicationArea = all;
                    Caption = 'Payment Method Code';
                    StyleExpr = StyleTxt;
                }
                field(GtextDescription; GtextDescription) { ApplicationArea = all; Caption = 'Description'; StyleExpr = StyleTxt; }
                field("Limit Type"; "Limit Type")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the type of limit that applies to the approval template:';

                }
                field(Amount; Amount) { ApplicationArea = all; StyleExpr = StyleTxt; }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval. The amount is stated in the local currency.';
                    StyleExpr = StyleTxt;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the sales or purchase lines.';
                    StyleExpr = StyleTxt;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies when the record must be approved, by one or more approvers.';
                    StyleExpr = StyleTxt;
                }
                field(SenderName; SenderName) { ApplicationArea = all; Caption = 'Sender Name'; StyleExpr = StyleTxt; }
                field("Date-Time Sent for Approval"; "Date-Time Sent for Approval")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date and the time that the document was sent for approval.';
                    StyleExpr = StyleTxt;
                }
                field(ApproverName; ApproverName) { ApplicationArea = all; Caption = 'Approver Name'; StyleExpr = StyleTxt; }
                field(lastmodifiedusername; lastmodifiedusername) { ApplicationArea = all; Caption = 'Last Modified User'; StyleExpr = StyleTxt; }
                field("Approval Type"; "Approval Type")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies which approvers apply to this approval template:';

                }
                field(RecordIDText; RecordIDText)
                {
                    ApplicationArea = Suite;
                    Caption = 'To Approve';
                    Visible = false;
                    ToolTip = 'Specifies the record that you are requested to approve.';

                }
                field(Details; RecordDetails)
                {
                    ApplicationArea = Suite;
                    Caption = 'Details';
                    ToolTip = 'Specifies the record that the approval is related to.';
                    Visible = false;
                }
                field("Sequence No."; "Sequence No.")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the order of approvers when an approval workflow involves more than one approver.';
                }
                field(Status; Status)
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the approval status for the entry:';
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the code for the salesperson or purchaser that was in the document to be approved. It is not a mandatory field, but is useful if a salesperson or a purchaser responsible for the customer/vendor needs to approve the document before it is processed.';
                }


                field("Available Credit Limit (LCY)"; "Available Credit Limit (LCY)")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the remaining credit (in LCY) that exists for the customer.';
                }

                field("Last Date-Time Modified"; "Last Date-Time Modified")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }

                field(RecordDetails; RecordDetails) { ApplicationArea = all; Visible = false; }

                field(Comment; Comment)
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.';
                }

                field(Overdue; Overdue)
                {
                    ApplicationArea = Suite;
                    Caption = 'Overdue';
                    Editable = false;
                    ToolTip = 'Specifies that the approval is overdue.';
                    Visible = false;
                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the table where the record that is subject to approval is stored.';
                    Visible = false;

                }


                field("Document Type"; "Document Type")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents:';
                    Visible = false;
                }





                field("Sender ID"; "Sender ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who sent the approval request for the document to be approved.';
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Sender ID");
                    end;
                }


                field("Approver ID"; "Approver ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who must approve the document.';
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Approver ID");
                    end;
                }


                field("Last Modified By User ID"; "Last Modified By User ID")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Last Modified By User ID");
                    end;
                }


            }
            part(applyvendorentriespage; "ApplyVendor Entries")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = Rec."Document No." <> '';
                SubPageLink = "Applies-to ID" = FIELD("Document No.");
                UpdatePropagation = Both;
            }
            part("ApprovalEntries"; ApprovalEntriesBasePageAppOp)
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = Rec."Document No." <> '';
                SubPageLink = "Document No." = field("Document No.");
            }

        }
        area(factboxes)
        {
            part(Change; "Workflow Change List FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                UpdatePropagation = SubPart;
                Visible = ShowChangeFactBox;
            }
            systempart(Control5; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control4; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action("Record")
                {
                    ApplicationArea = Suite;
                    Caption = 'Record';
                    Enabled = ShowRecCommentsEnabled;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Open the document, journal line, or card that the approval request is for.';

                    trigger OnAction()
                    begin
                        ShowRecord;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Enabled = ShowRecCommentsEnabled;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                    begin
                        RecRef.Get("Record ID to Approve");
                        Clear(ApprovalsMgmt);
                        ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef, "Workflow Step Instance ID");
                    end;
                }
                action("O&verdue Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;
                    ToolTip = 'View approval requests that are overdue.';

                    trigger OnAction()
                    begin
                        SetFilter(Status, '%1|%2', Status::Created, Status::Open);
                        SetFilter("Due Date", '<%1', Today);
                    end;
                }
                action("All Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'All Entries';
                    Image = Entries;
                    ToolTip = 'View all approval entries.';

                    trigger OnAction()
                    begin
                        SetRange(Status);
                        SetRange("Due Date");
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action("Approve ")
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        GenJnlLine: Record "Gen. Journal Line";
                        ApprovalEntries: Record "Approval Entry";
                        RecID: RecordId;
                        Recref: RecordRef;
                    begin
                        CurrPage.SetSelectionFilter(ApprovalEntries);
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntries);
                    end;
                }
                action("View Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'View Invoices';
                    Visible = false;
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    //Visible = true;

                    trigger OnAction()
                    var
                        gpagemt101vendorledgerentries: Page 50031;
                        venderledgerentryrec: Record "Vendor Ledger Entry";
                    begin
                        venderledgerentryrec.Reset();
                        venderledgerentryrec.SetCurrentKey("Entry No.");
                        venderledgerentryrec.SetFilter("Applies-to ID", "Document No.");
                        if venderledgerentryrec.FindFirst() then begin
                            gpagemt101vendorledgerentries.SetTableView(venderledgerentryrec);
                            gpagemt101vendorledgerentries.Run();

                        end;
                    end;
                }

                action("Reject ")
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the approval request.';
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ApprovalEntries: Record "Approval Entry";
                    begin
                        CurrPage.SetSelectionFilter(ApprovalEntries);
                        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntries);
                        /*
                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Document No.", "Document No.");
                        if GenJournalLine.FindFirst then
                            ApprovalsMgmt.RejectGenJournalLineRequest(GenJournalLine);
                        */
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    Visible = false;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Document No.", "Document No.");
                        if GenJournalLine.FindFirst then
                            ApprovalsMgmt.DelegateGenJournalLineRequest(GenJournalLine);
                    end;
                }
                /* action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if OpenApprovalEntriesOnJnlLineExist then
                            ApprovalsMgmt.GetApprovalComment(Rec)
                        else
                            if OpenApprovalEntriesOnJnlBatchExist then
                                if GenJournalBatch.Get("Journal Template Name", "Journal Batch Name") then
                                    ApprovalsMgmt.GetApprovalComment(GenJournalBatch);
                    end;
                } */
            }
        }
        area(processing)
        {
            action("&Delegate")
            {
                ApplicationArea = Suite;
                Caption = '&Delegate';
                Enabled = DelegateEnable;
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Delegate the approval request to another approver that has been set up as your substitute approver.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SetSelectionFilter(ApprovalEntry);
                    ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    var
        RecRef: RecordRef;
    begin
        ShowChangeFactBox := CurrPage.Change.PAGE.SetFilterFromApprovalEntry(Rec);
        DelegateEnable := CanCurrentUserEdit;
        ShowRecCommentsEnabled := RecRef.Get("Record ID to Approve");
    end;

    trigger OnAfterGetRecord()
    var
        userrec: Record User;
        genjourlinerec: Record "Gen. Journal Line";

    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;

        RecordIDText := Format("Record ID to Approve", 0, 1);

        Clear(GtextDescription);
        genjourlinerec.Reset();
        genjourlinerec.SetRange("Document No.", "Document No.");
        if genjourlinerec.FindFirst then
            GtextDescription := genjourlinerec.Description;



        userrec.Reset();
        userrec.SetRange("User Name", "Sender ID");
        if userrec.FindFirst then
            SenderName := userrec."Full Name";

        userrec.Reset();
        userrec.SetRange("User Name", "Approver ID");
        if userrec.FindFirst then
            ApproverName := userrec."Full Name";

        userrec.Reset();
        userrec.SetRange("User Name", "Last Modified By User ID");
        if userrec.FindFirst then
            lastmodifiedusername := userrec."Full Name";

        StyleTxt := SetStyle;
    end;

    trigger OnOpenPage()
    begin
        MarkAllWhereUserisApproverOrSender;
    end;

    var
        Overdue: Option Yes," ";
        RecordIDText: Text;
        ShowChangeFactBox: Boolean;
        DelegateEnable: Boolean;
        ShowRecCommentsEnabled: Boolean;
        approvername: Text[100];
        sendername: Text[100];
        lastmodifiedusername: Text[100];

        OpenApprovalEntriesExistForCurrUser: Boolean;

        OpenApprovalEntriesOnJnlLineExist: Boolean;

        OpenApprovalEntriesExistForCurrUserBatch: Boolean;

        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;

        OpenApprovalEntriesOnJnlBatchExist: Boolean;

        CanCancelApprovalForJnlLine: Boolean;

        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;

        CanCancelFlowApprovalForLine: Boolean;

        CanRequestFlowApprovalForBatch: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GtextDescription: Text;
        StyleTxt: Text;
        PaymentMethodCodeGVar: Code[10];

    procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
            FilterGroup(2);
            SetCurrentKey("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval");
            SetRange("Table ID", TableId);
            SetRange("Document Type", DocumentType);
            if DocumentNo <> '' then
                SetRange("Document No.", DocumentNo);
            FilterGroup(0);
        end;
    end;

    local procedure FormatField(ApprovalEntry: Record "Approval Entry"): Boolean
    begin
        if Status in [Status::Created, Status::Open] then begin
            if ApprovalEntry."Due Date" < Today then
                exit(true);

            exit(false);
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        CanRequestFlowApprovalForLine: Boolean;
    begin
        OpenApprovalEntriesExistForCurrUser :=
          OpenApprovalEntriesExistForCurrUserBatch or ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);

        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or OpenApprovalEntriesOnJnlLineExist;

        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(RecordId, CanRequestFlowApprovalForLine, CanCancelFlowApprovalForLine);
        CanRequestFlowApprovalForBatchAndCurrentLine := CanRequestFlowApprovalForBatch and CanRequestFlowApprovalForLine;
    end;



    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;

    procedure SetStyle() Result: Text
    var
        IsHandled: Boolean;
        RecRef: RecordRef;
        GenJnlLineLRec: Record "Gen. Journal Line";
    begin
        Clear(PaymentMethodCodeGVar);

        if not RecRef.Get("Record ID to Approve") then
            exit('');
        case RecRef.Number of
            DATABASE::"Gen. Journal Line":
                begin
                    RecRef.SetTable(GenJnlLineLRec);
                    PaymentMethodCodeGVar := GenJnlLineLRec."Payment Method Code";
                    if GenJnlLineLRec."Payment Method Code" = 'MT101' then
                        exit('Strong')
                    else
                        exit('');
                end;
            else
                exit('');
        end;
    end;
}

