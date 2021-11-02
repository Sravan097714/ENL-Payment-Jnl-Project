pageextension 50094 CashReceiptJournalExt extends "Cash Receipt Journal"
{
    layout
    {
        modify("Applied (Yes/No)")
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        //LS02072021--START
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
        modify("External Document No.")
        {
            Visible = true;
        }
        addafter("Account No.")
        {
            field(CustomerName; CustomerName)
            {
                ApplicationArea = all;
                Caption = 'Customer Name';
            }
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
        addafter("Document Type")
        {
            field(Status; Status)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

    }

    actions
    {
        modify(IncomingDoc)
        {
            Visible = false;
        }
        addafter("Post and &Print")
        {
            action("Post and Mail")
            {
                ApplicationArea = all;
                Caption = 'Post and Mail';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    JnlLine: Record "Gen. Journal Line";
                begin
                    GenJrnlLineGRecTemp.DeleteAll();
                    JnlLine.Reset();
                    JnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    JnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    if JnlLine.FindSet() then
                        repeat
                            GenJrnlLineGRecTemp.Init();
                            GenJrnlLineGRecTemp := JnlLine;
                            GenJrnlLineGRecTemp.Insert();
                        until JnlLine.Next() = 0;

                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", Rec);

                    GenJrnlLineGRecTemp.Reset();
                    GenJrnlLineGRecTemp.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJrnlLineGRecTemp.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    if GenJrnlLineGRecTemp.FindSet() then
                        repeat
                            ChecktoSendMail(GenJrnlLineGRecTemp);
                        until GenJrnlLineGRecTemp.Next() = 0;

                    CurrPage.Update(false);
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
    local procedure ChecktoSendMail(GenJnlLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        Vend: Record Vendor;
    begin
        case GenJnlLine."Account Type" of
            GenJnlLine."Account Type"::Customer:
                Cust.get(GenJnlLine."Account No.");
            GenJnlLine."Account Type"::Vendor:
                Vend.get(GenJnlLine."Account No.");
        end;
        case GenJnlLine."Bal. Account Type" of
            GenJnlLine."Bal. Account Type"::Customer:
                Cust.get(GenJnlLine."Account No.");
            GenJnlLine."Bal. Account Type"::Vendor:
                Vend.get(GenJnlLine."Account No.");
        end;
        if Vend."E-Mail" <> '' then
            SendMail(GenJnlLine, Vend."E-Mail");
        if Cust."E-Mail" <> '' then
            SendMail(GenJnlLine, Cust."E-Mail");
    end;

    procedure AttachReport(GenJnlLine: Record "Gen. Journal Line"; FileName: Text)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJnlTemplate: Record "Gen. Journal Template";
        GLReg: Record "G/L Register";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        IsHandled: Boolean;
    begin
        GenJnlTemplate.Get(GenJnlLine."Journal Template Name");

        GeneralLedgerSetup.Get();
        if GLReg.FindLast() then begin
            if GenJnlTemplate."Cust. Receipt Report ID" <> 0 then begin
                CustLedgEntry.SetRange("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                if not GeneralLedgerSetup."Post & Print with Job Queue" then
                    REPORT.SaveAsPdf(GenJnlTemplate."Cust. Receipt Report ID", FileName, CustLedgEntry);
            end;
            if GenJnlTemplate."Vendor Receipt Report ID" <> 0 then begin
                VendLedgEntry.SetRange("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                if not GeneralLedgerSetup."Post & Print with Job Queue" then
                    REPORT.SaveAsPdf(GenJnlTemplate."Vendor Receipt Report ID", FileName, VendLedgEntry);
            end;
            if GenJnlTemplate."Posting Report ID" <> 0 then begin
                GLReg.SetRecFilter;
                if not GeneralLedgerSetup."Post & Print with Job Queue" then
                    REPORT.SaveAsPdf(GenJnlTemplate."Posting Report ID", FileName, GLReg);
            end;
        end;
    end;

    local procedure SendMail(GenJnlLine: Record "Gen. Journal Line"; MailID: Text)
    var
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        ServerFileName: Text;
        FileMgt: Codeunit "File Management";
    begin
        if MailID = '' then
            exit;
        SMTPSetup.Get();
        SMTPMail.CreateMessage('', SMTPSetup."User ID", MailID, 'Official Receipt', '', true);
        SMTPMail.AppendBody('Dear Sir/Madam,');
        SMTPMail.AppendBody('<br></br>');
        SMTPMail.AppendBody('<br></br>');
        SMTPMail.AppendBody('Please find the attachment below.');
        ServerFileName := FileMgt.ServerTempFileName('.pdf');
        AttachReport(GenJnlLine, ServerFileName);
        if Exists(ServerFileName) then begin
            SMTPMail.AddAttachment(ServerFileName, 'Official Receipt - MUR.pdf');
            SMTPMail.Send();
            Message('Mail Sent Successfully');
        end;
    end;

    var
        myInt: Integer;
        GenJrnlLineGRecTemp: Record "Gen. Journal Line" temporary;
}