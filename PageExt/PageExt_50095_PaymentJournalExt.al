pageextension 50095 PaymentJournalExt extends "Payment Journal"
{
    layout
    {
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Applied (Yes/No)")
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify(AppliesToDocNo)
        {
            Visible = false;
        }
        modify(GetAppliesToDocDueDate)
        {
            Visible = false;
        }

        modify(Correction)
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = true;
        }
        modify(TotalExportedAmount)
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }
        modify("Has Payment Export Error")
        {
            Visible = false;
        }
        modify("Number of Lines")
        {
            Visible = false;
        }
        modify(Control1900545401)
        {
            Visible = false;
        }
        modify("Total Balance")
        {
            Visible = false;
        }

        addafter("Bank Payment Type")
        {
            field(Payee; Payee)
            {
                ApplicationArea = all;
                Caption = 'Payee Name';
                Editable = false;
            }
        }
        addafter("External Document No.")
        {
            field("ENL -Doc No"; "ENL -Doc No")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'ENL - Document No.';
            }
        }
        addafter("Document Type")
        {
            field(Status; Status)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Approval Route"; "Approval Route")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    if Rec."Approval Route" = '' then
                        Error('Approval Route cannot be empty for payment line.');
                end;
            }
        }



        addlast(Control1)
        {

            field("Check Transmitted"; "Check Transmitted") { ApplicationArea = All; }
        }
    }
    actions
    {
        addafter(Workflow)
        {
            action("Payment Remittance Before Post")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Remittance Before post';
                Image = PreviewChecks;
                ToolTip = 'View journal line entries, payment discounts, discount tolerance amounts, payment tolerance, and any errors associated with the entries. You can use the results of the report to review payment journal lines and to review the results of posting before you actually post.';

                trigger OnAction()
                var
                    GenJournalBatch: Record "Gen. Journal Batch";
                begin
                    GenJournalBatch.Init();
                    GenJournalBatch.SetRange("Journal Template Name", "Journal Template Name");
                    GenJournalBatch.SetRange(Name, "Journal Batch Name");
                    REPORT.Run(REPORT::"PaymentRemittanceBeforePost", true, false, GenJournalBatch);
                end;

            }
            action("Vendor Remittance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Remittance';
                Image = PreviewChecks;
                ToolTip = 'View journal line entries, payment discounts, discount tolerance amounts, payment tolerance, and any errors associated with the entries. You can use the results of the report to review payment journal lines and to review the results of posting before you actually post.';

                trigger OnAction()
                var
                    GenJournalBatch: Record "Gen. Journal Batch";
                begin
                    GenJournalBatch.Init();
                    GenJournalBatch.SetRange("Journal Template Name", "Journal Template Name");
                    GenJournalBatch.SetRange(Name, "Journal Batch Name");
                    REPORT.Run(REPORT::"Vendor Remittance", true, false, GenJournalBatch);
                end;

            }
            action("Vendor Remittance Before Post")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Remittance Manual Check';
                Image = PreviewChecks;
                trigger OnAction()
                var
                    GenJournalBatch: Record "Gen. Journal Batch";
                begin
                    GenJournalBatch.Init();
                    GenJournalBatch.SetRange("Journal Template Name", "Journal Template Name");
                    GenJournalBatch.SetRange(Name, "Journal Batch Name");
                    REPORT.Run(REPORT::"Vendor Remittance Before Post", true, false, GenJournalBatch);
                end;

            }
        }
        addafter("Request Approval")
        {
            group(Action21)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ApprlMgt: Codeunit "Approvals Mgmt.";
                        GenJnlLineLRec: Record "Gen. Journal Line";
                        ReleaseErr: Label 'Manual release is not allowed for the Journal Document no. %1 Line No. %2, Please go through approval process.';
                    begin
                        CurrPage.SetSelectionFilter(GenJnlLineLRec);
                        if GenJnlLineLRec.FindSet() then
                            repeat
                                if ApprlMgt.IsGeneralJournalLineApprovalsWorkflowEnabled(GenJnlLineLRec) then
                                    Error(ReleaseErr, GenJnlLineLRec."Document No.", GenJnlLineLRec."Line No.");
                                GenJnlLineLRec.Status := GenJnlLineLRec.Status::Released;
                                GenJnlLineLRec.Modify(true);
                            until GenJnlLineLRec.Next() = 0;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Enabled = Status <> Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        GenJnlLineLRec: Record "Gen. Journal Line";
                    begin
                        CurrPage.SetSelectionFilter(GenJnlLineLRec);
                        if GenJnlLineLRec.FindSet() then
                            repeat
                                GenJnlLineLRec.TestField(Status, GenJnlLineLRec.Status::Released);
                                GenJnlLineLRec.Status := GenJnlLineLRec.Status::Open;

                                GenJnlLineLRec.Modify(true);
                            until GenJnlLineLRec.Next() = 0;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(xRrec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec.TestField("Approval Route");
    end;


}