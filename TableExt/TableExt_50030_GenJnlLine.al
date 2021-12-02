tableextension 50030 GenJnlLineExt1 extends "Gen. Journal Line"
{
    fields
    {
        field(50001; Payee; text[250])
        {
            //FieldClass = FlowField; //B2BSRA1.0 
            Caption = 'Payee Name';
            //CalcFormula = lookup(Vendor.PayeeName where("No." = field("Account No.")));
        }
        field(50002; "Approval Route"; Code[20])
        {
            TableRelation = "Approval Route";
        }
        field(50003; "DocAttachedID"; Text[250])
        {
            //FieldClass = FlowField;
            //CalcFormula = lookup("Vendor Ledger Entry"."Document No." where("Applies-to ID" = field("Document No.")));

        }
        field(50004; "DocumentAttachedID"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Ledger Entry"."Document No." where("Applies-to ID" = field("Document No.")));

        }
        field(50005; "ApproverID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field("Document No.")));
        }
        field(50006; "Last ApproverID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Last Modified By User ID" where("Document No." = field("Document No.")));
        }
        field(50007; CustomerName; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                customerrec: Record customer;
                vendorrec: Record Vendor;
                Approvalmgt: Codeunit "Approvals Mgmt.";
                VenApprovalErr: Label 'Approval is pending for Vendor %1 to do payments.';
                CustApprovalErr: Label 'Approval is required for Customer %1 to do payments.';
            begin
                /* B2BSRA1.0
                customerrec.SetRange("No.", "Account No.");
                if customerrec.FindFirst then
                    CustomerName := customerrec.Name;

                vendorrec.Reset();
                vendorrec.SetRange("No.", "Account No.");
                if vendorrec.FindFirst then
                    Payee := vendorrec.PayeeName;
                */
                //B2BSRA1.0 >>
                case "Account Type" of
                    "Account Type"::Vendor:
                        begin
                            if vendorrec.Get("Account No.") then begin
                                /*
                                if Approvalmgt.HasOpenOrPendingApprovalEntries(vendorrec.RecordId) then
                                    Error(VenApprovalErr, vendorrec."No.");
                                if not Approvalmgt.HasApprovalEntries(vendorrec.RecordId) then
                                    Error(VenApprovalErr, vendorrec."No.");
                                */
                                if vendorrec.PayeeName <> '' then
                                    Payee := vendorrec.PayeeName
                                else
                                    Payee := vendorrec.Name;
                            end;
                        end;

                    "Account Type"::Customer:
                        begin
                            if customerrec.Get("Account No.") then begin
                                if Approvalmgt.HasOpenOrPendingApprovalEntries(customerrec.RecordId) then
                                    Error(CustApprovalErr, customerrec."No.");
                                if not Approvalmgt.HasApprovalEntries(customerrec.RecordId) then
                                    Error(CustApprovalErr, customerrec."No.");
                                CustomerName := customerrec.Name;
                            end;
                        end;
                end;
                ////B2BSRA1.0 <<
            end;
        }
        field(50010; "ENL -Doc No"; Code[20])
        {
            //DataClassification = ToBeClassified;
            //Caption = 'Cheque Number';
            FieldClass = Normal;
            Editable = false;
            //CalcFormula = lookup("Gen. Journal Line"."Document No.");

        }
        field(50011; "File Exported Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; Status; Enum "Gen. Jnl Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'B2BSRA1.0';
        }
        modify("Document No.")
        {
            trigger OnAfterValidate()
            begin
                "ENL -Doc No" := "Document No.";
            end;
        }

        modify("Payment Method Code")
        {
            trigger OnAfterValidate()
            var
                GenBatchLRec: Record "Gen. Journal Batch";
            begin
                GenBatchLRec.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                if Not GenBatchLRec.MT101 then begin
                    if "Payment Method Code" = 'MT101' then
                        Error('Payment Method Cannot be %1 in this batch.', "Payment Method Code");
                end else
                    Rec.TestField("Payment Method Code", 'MT101');

            end;
        }
    }
    trigger OnBeforeModify()
    begin
        TestField(Status, Status::Open);
    end;

    trigger OnBeforeRename()
    begin
        TestField(Status, Status::Open);
    end;

    trigger OnBeforeDelete()
    begin
        TestField(Status, Status::Open);
    end;
}