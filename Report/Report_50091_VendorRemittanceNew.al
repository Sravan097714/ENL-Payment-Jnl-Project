report 50091 "Vendor Remittance Before Post"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Vendor Remittance';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\VendorRemittanceBeforePost.rdl';

    dataset
    {
        dataitem("Gen. Journal Batch"; "Gen. Journal Batch")
        {
            PrintOnlyIfDetail = true;
            column(Gen__Journal_Batch_Journal_Template_Name; "Journal Template Name") { }
            column(Gen__Journal_Batch_Name; Name) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(PrintDate; Format(WorkDate())) { }
            column(PreparedBy_Caption; PreparedBy_CaptionLBl) { }
            column(ApprovedBy_Caption; ApprovedBy_CaptionLBl) { }
            column(Delivered_By_Caption; '') { }
            dataitem("Gen. Journal Line"; "Gen. Journal Line")
            {
                DataItemLink = "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD(Name);
                DataItemLinkReference = "Gen. Journal Batch";
                DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.") where("Account Type" = const(Vendor), Amount = filter(<> 0));
                RequestFilterFields = "Posting Date";
                column(Document_No_GenJnl; "Document No.") { }
                column(Account_No_; "Account No.") { }
                column(Description; Description) { }
                column(Amount; Amount) { }
                column(VAT_Amount; "VAT Amount") { }
                column(Posting_Date; "Posting Date") { }
                column(VendorRec_Name; VendorRec.Name) { }
                column(VendorRec_Address; VendorRec.Address) { }
                column(VendorRec_Address2; VendorRec."Address 2") { }
                column(VendorRec_City; VendorRec.City) { }
                column(ApprovedBy; ApprovedBy) { }
                column(PreparedBy; PreparedBy) { }
                column(External_Document_No_; "External Document No.") { }
                column(Line_No_; "Line No.") { }
                column(TotalAmount; TotalAmount) { }
                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Vendor No." = FIELD("Account No."), "Applies-to ID" = FIELD("Applies-to ID");
                    DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code") where("Applies-to ID" = filter(<> ''));
                    CalcFields = Amount;
                    column(Document_No_VLE; "External Document No.") { }
                    column(Description_VLE; Description) { }
                    column(Amount_to_Apply; "Amount to Apply") { }
                    column(Amount_VLE; Amount) { }
                    column(Entry_No_; "Entry No.") { }
                }
                trigger OnPreDataItem()
                begin
                    SetCurrentKey("Account No.");
                end;

                trigger OnAfterGetRecord()
                var
                    ApprovalEntries: Record "Approval Entry";
                begin
                    Clear(ApprovedBy);
                    clear(PreparedBy);
                    if PrevAccNo <> "Account No." then
                        clear(TotalAmount);
                    PrevAccNo := "Account No.";

                    TotalAmount += Amount;

                    if not VendorRec.Get("Account No.") then
                        Clear(VendorRec);


                    userrec.Reset();
                    userrec.SetRange("User Name", UserId);
                    if userrec.FindFirst then
                        PreparedBy := userrec."Full Name";

                    ApprovalEntries.Reset();
                    ApprovalEntries.SetCurrentKey("Last Date-Time Modified");
                    ApprovalEntries.SetRange("Document No.", "Document No.");
                    ApprovalEntries.SetRange(Status, "Approval Status"::Approved);
                    if ApprovalEntries.FindLast() then begin
                        userrec.Reset();
                        userrec.SetRange("User Name", ApprovalEntries."Approver ID");
                        if not userrec.FindFirst then
                            clear(UserRec)
                        else
                            ApprovedBy := userrec."Full Name";
                    end;
                end;

            }
            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
            end;
        }
    }

    requestpage
    {
        layout
        {

        }

        actions
        {

        }
    }

    var
        myInt: Integer;
        PreparedBy_CaptionLBl: Label 'Prepared By :';
        ApprovedBy_CaptionLBl: Label 'Approved By :';
        ApprovedBy: Text;
        PreparedBy: Text;
        UserRec: Record User;
        CompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
        TotalAmount: Decimal;
        PrevAccNo: Code[20];
}