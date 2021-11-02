report 50036 "Payment Register Finance"
{

    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layout\PaymentRegisterSof.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Source Code" = FILTER('PAYMENTJNL'));
            RequestFilterFields = "No.";

            column(CompanyInfoName; UPPERCASE(CompanyInfo.Name)) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfoAddr; CompanyInfo.Address) { }
            column(CompanyInfoAddr2; CompanyInfo."Address 2") { }
            column(CompanyInfoCity; CompanyInfo.City) { }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyInfoBRN; CompanyInfo.BRN) { }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfoFax; CompanyInfo."Fax No.") { }
            column(CompanyInfoHomePage; CompanyInfo."Home Page") { }
            column(PAYMENTREGISTER_Caption; PAYMENTREGISTER_CaptionLbl) { }
            column(Page_Caption; Page_CaptionLbl) { }
            column(FilteredBy_Caption; FilteredBy_CaptionLbl) { }
            column(RegisterNo_Caption; RegisterNo_CaptionLbl) { }
            column(DocumentType_Caption; DocumentType_CaptionLbl) { }
            column(PaymentNumber_Caption; PaymentNumber_CaptionLbl) { }
            column(ChequeDate_Caption; ChequeDate_CaptionLbl) { }
            column(VendorNo_Caption; VendorNo_CaptionLbl) { }
            column(PayeeName_Caption; PayeeName_CaptionLbl) { }
            column(BankAccount_Caption; BankAccount_CaptionLbl) { }
            column(Name_Caption; Name_CaptionLbl) { }
            column(Amount_Caption; Amount_CaptionLbl) { }
            column(GrandTotal_Caption; GrandTotal_CaptionLbl) { }
            column(PREPARED_PROCESSED_Caption; PREPARED_PROCESSED_CaptionLbl) { }
            column(APPROVED_Caption; APPROVED_CaptionLbl) { }
            column(STCHEQUESIGNATURE_Caption; "1STCHEQUESIGNATURE_CaptionLbl") { }
            column(NDCHEQUESIGNATURE_Caption; "2NDCHEQUESIGNATURE_CaptionLbl") { }
            column(RECEIVED_Caption; RECEIVED_CaptionLbl) { }
            column(DATE_Caption; DATE_CaptionLbl) { }
            column(No_GLRegister; "G/L Register"."No.") { }
            column(PayeeName; PayeeName) { }
            column(Bank_Name; Bank.Name) { }
            column(Amt; ABS(Amt)) { }
            column(USERID; UPPERCASE(USERID)) { }
            column(useridname; UPPERCASE(useridname)) { }
            column(CreationDate_GLRegister; "G/L Register"."Creation Date") { }
            column(GLRegister_GETFILTERS; "G/L Register".GETFILTERS) { }
            column(ShowLineGVar; ShowLineGVar) { }
            column(Rep_50093_Caption; Rep_50093_CaptionLbl) { }
            column(CountofRecord; Index) { }


            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date")
                                    WHERE(Amount = FILTER(< 0),
                                    "Source Code" = FILTER('PAYMENTJNL'));
                RequestFilterFields = "Document No.", "Posting Date";

                column(DocumentType_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Type") { }
                column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.") { }
                column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date") { }
                column(BalAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bal. Account No.") { }
                column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.") { }
                column(Amount_BankAccountLedgerEntry; ABS("Bank Account Ledger Entry".Amount)) { }
                column(BankShowLineGVar; BankShowLineGVar) { }
                column(approval1id; approval1id) { }
                column(approvalname; approvalname) { }
                column(approval1time; approval1time) { }
                column(sign1id; sign1id) { }
                column(sign1name; sign1name) { }
                column(sign1time; sign1time) { }
                column(sign2id; sign2id) { }
                column(sign2name; sign2name) { }
                column(sign2time; sign2time) { }
                column(External_Document_No_Bank; "External Document No.") { }
                column(Description_Bank; Description) { }

                //RCTS1.0 09/01/20
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemTableView = where("Initial Document Type" = const(Invoice));
                    DataItemLinkReference = "Bank Account Ledger Entry";
                    DataItemLink = "Document No." = field("Document No."), "Vendor No." = field("Bal. Account No.");

                    dataitem(VLEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLinkReference = "Detailed Vendor Ledg. Entry";
                        DataItemLink = "Entry No." = field("Vendor Ledger Entry No.");

                        column(Document_No_; "Document No.") { }
                        column(Description; Description) { }
                        column(External_Document_No_; "External Document No.") { }
                    }
                }
                //RCTS1.0 09/01/20


                trigger OnAfterGetRecord()
                var
                    postedapprovalentriesrec: Record "Posted Approval Entry";
                    userrec: Record User;
                begin
                    IF Bank.GET("Bank Account Ledger Entry"."Bank Account No.") THEN;

                    if "Document Type" = "Document Type"::Payment then
                        Index += 1;
                    //ZS-001
                    //IF GetMultipleRec.GetCustomer(Cust,TRUE,"Customer No.") THEN;

                    CLEAR(PayeeName);
                    IF GetMultipleRec.GetVendor(recVendor, TRUE, "Bank Account Ledger Entry"."Bal. Account No.") THEN BEGIN
                        IF recVendor."Pay-to Vendor No." = '' THEN BEGIN
                            PayeeName := recVendor.Name;
                        END ELSE BEGIN
                            IF GetMultipleRec.GetVendor(recVendor1, TRUE, recVendor."Pay-to Vendor No.") THEN BEGIN
                                PayeeName := recVendor1.Name;
                            END;
                        END;
                    END;

                    IF "Bank Account Ledger Entry".HASFILTER THEN
                        BankShowLineGVar := TRUE
                    ELSE
                        BankShowLineGVar := FALSE;

                    Amt += ABS("Bank Account Ledger Entry".Amount);



                    Clear(approval1id);
                    Clear(approval1time);
                    clear(approvalname);
                    postedapprovalentriesrec.Reset();
                    postedapprovalentriesrec.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
                    postedapprovalentriesrec.SetRange("Sequence No.", 1);
                    postedapprovalentriesrec.SetRange(Status, "Approval Status"::Approved);
                    if postedapprovalentriesrec.FindFirst then begin
                        approval1id := postedapprovalentriesrec."Approver ID";
                        approval1time := postedapprovalentriesrec."Last Date-Time Modified";
                        userrec.Reset();
                        userrec.SetRange("User Name", approval1id);
                        if userrec.FindFirst then
                            approvalname := userrec."Full Name";

                    end;
                    Clear(sign1id);
                    Clear(sign1time);
                    clear(sign1name);
                    postedapprovalentriesrec.Reset();
                    postedapprovalentriesrec.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
                    postedapprovalentriesrec.SetRange("Sequence No.", 2);
                    postedapprovalentriesrec.SetRange(Status, "Approval Status"::Approved);
                    if postedapprovalentriesrec.FindFirst then begin
                        sign1id := postedapprovalentriesrec."Approver ID";
                        sign1time := postedapprovalentriesrec."Last Date-Time Modified";
                        userrec.Reset();
                        userrec.SetRange("User Name", sign1id);
                        if userrec.FindFirst then
                            sign1name := userrec."Full Name";

                    end;

                    Clear(sign2id);
                    Clear(sign2time);
                    Clear(sign2name);
                    postedapprovalentriesrec.Reset();
                    postedapprovalentriesrec.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
                    postedapprovalentriesrec.SetRange("Sequence No.", 3);
                    postedapprovalentriesrec.SetRange(Status, "Approval Status"::Approved);
                    if postedapprovalentriesrec.FindFirst then begin
                        sign2id := postedapprovalentriesrec."Approver ID";
                        sign2time := postedapprovalentriesrec."Last Date-Time Modified";
                        userrec.Reset();
                        userrec.SetRange("User Name", sign2id);
                        if userrec.FindFirst then
                            sign2name := userrec."Full Name";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(Amt);
                    SETRANGE("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                    //CurrReport.CREATETOTALS(Amount);
                end;
            }

            trigger OnAfterGetRecord()
            var
                userrec: Record User;
            begin
                IF "G/L Register".HASFILTER THEN
                    ShowLineGVar := TRUE
                ELSE
                    ShowLineGVar := FALSE;

                userrec.Reset();
                userrec.SetRange("User Name", UserId);
                if userrec.FindFirst then useridname := userrec."Full Name";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
            end;
        }
    }

    trigger OnPostReport()
    begin
        IF Index = 0 THEN
            ERROR('No Records found.');
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CalcFields(Picture);
        Index := 0;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Bank: Record 270;
        Amt: Decimal;
        CompanyInfo: Record 79;
        Index: Integer;
        PayeeName: Text[100];
        GetMultipleRec: Codeunit 50031;
        GetSetup: Codeunit 50030;
        recVendor: Record 23;
        recVendor1: Record 23;
        PAYMENTREGISTER_CaptionLbl: Label 'PAYMENT REGISTER';
        Page_CaptionLbl: Label 'Page';
        FilteredBy_CaptionLbl: Label 'Filtered By:';
        RegisterNo_CaptionLbl: Label '<b>Register No.</b>';
        DocumentType_CaptionLbl: Label 'Document Type';
        PaymentNumber_CaptionLbl: Label 'Payment Number';
        ChequeDate_CaptionLbl: Label 'Cheque Date';
        VendorNo_CaptionLbl: Label 'Vendor No.';
        PayeeName_CaptionLbl: Label 'Payee Name';
        BankAccount_CaptionLbl: Label 'Bank Account';
        Name_CaptionLbl: Label 'Name';
        Amount_CaptionLbl: Label 'Amount';
        GrandTotal_CaptionLbl: Label 'Grand Total';
        PREPARED_PROCESSED_CaptionLbl: Label 'PREPARED/PROCESSED';
        APPROVED_CaptionLbl: Label 'APPROVED';
        "1STCHEQUESIGNATURE_CaptionLbl": Label '1ST CHEQUE SIGNATURE';
        "2NDCHEQUESIGNATURE_CaptionLbl": Label '2ND CHEQUE SIGNATURE';
        RECEIVED_CaptionLbl: Label 'RECEIVED';
        DATE_CaptionLbl: Label 'DATE';
        ShowLineGVar: Boolean;
        Rep_50093_CaptionLbl: Label 'Rep-50093';
        BankShowLineGVar: Boolean;
        grecBankAccLedgerEntry: Record "Bank Account Ledger Entry";

        approverid: Text[50];
        approvernamevend: Text[50];
        sendernamevend: Text[50];
        sendernam: Text[100];
        approvernamecust: Text[50];
        approvernamegen: Text[50];
        nam: Text[50];

        approvdate: DateTime;
        approval1id: Text[50];
        approval1time: DateTime;
        approvalname: Text[50];
        sign1id: Text[50];
        sign1time: DateTime;
        sign1name: Text[50];
        sign2id: Text[50];
        sign2time: DateTime;
        sign2name: Text[50];
        poapprovedname: Text[50];
        username: Text[50];
        useridname: Text[50];
}

