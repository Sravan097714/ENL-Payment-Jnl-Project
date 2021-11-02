codeunit 50033 "MT101 Generator"
{
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin
        GenJrnlGRec.copy(Rec);
        Code();
        Rec := GenJrnlGRec;
    end;


    var
        TempPaymentJournal: Record "Gen. Journal Line" temporary;
        GenJrnlGRec: Record "Gen. Journal Line";
        Mt101SFTPSetup: Record "MT101 SFTP Setup";
        SwiftFile: File;
        SwiftOutStream: OutStream;
        FileMgt: Codeunit "File Management";
        MT101FilePath: Text;
        MT101FileName: Text;
        CheckSum: DotNet CheckSum;
        FileInfo: DotNet FileInfo;
        FileInfo2: DotNet FileInfo;
        AccNo: Code[20];
        BalAccNo: code[20];
        BankAccount: Record "Bank Account";
        CountyGRec: Record "Country/Region";
        MT101LogReg: Record "MT101 Log Register";
        MT101LogEntry: Record "MT101 Log Entry";

    local procedure Code()
    var
        BankAccLRec: Record "Bank Account";
        VendorLrec: Record Vendor;
        PaymentJournal: Record "Gen. Journal Line";
        VendorLedger: Record "Vendor Ledger Entry";
        VendorBankAccountLRec: Record "Vendor Bank Account";
    begin
        ClearGlobals();
        CheckMT101Setup();
        TempPaymentJournal.DeleteAll();
        if GenJrnlGRec.FindFirst() then
            repeat
                /*
                    GenJrnlGRec.TestField("Exported to Payment File", false);
                    GenJrnlGRec.TestField("Approval Status", GenJrnlGRec."Approval Status"::Approved);
                    GenJrnlGRec.TestField("Bank Payment Type", GenJrnlGRec."Bank Payment Type"::"Electronic Payment");
                    */
                case GenJrnlGRec."Account Type" of
                    GenJrnlGRec."Account Type"::Vendor:
                        AccNo := GenJrnlGRec."Account No.";
                    GenJrnlGRec."Account Type"::"Bank Account":
                        BalAccNo := GenJrnlGRec."Account No.";
                end;
                case GenJrnlGRec."Bal. Account Type" of
                    GenJrnlGRec."Bal. Account Type"::Vendor:
                        AccNo := GenJrnlGRec."Bal. Account No.";
                    GenJrnlGRec."Bal. Account Type"::"Bank Account":
                        BalAccNo := GenJrnlGRec."Bal. Account No.";
                end;
                BankAccLRec.Get(BalAccNo);
                VendorLrec.Get(AccNo);
                TempPaymentJournal := GenJrnlGRec;
                TempPaymentJournal.Insert();
            until GenJrnlGRec.Next() = 0;

        if TempPaymentJournal.FindFirst() then begin
            MT101FilePath := GetPutFileName();

            MT101LogReg.CreateNew(TempPaymentJournal."Journal Template Name", TempPaymentJournal."Journal Batch Name", MT101FilePath, '', MT101LogReg);

            SwiftFile.Create(MT101FilePath);
            SwiftFile.CreateOutStream(SwiftOutStream);
            if not GenerateMT101File(MT101FilePath) then begin
                SwiftFile.Close();
                if Exists(MT101FilePath) then
                    Erase(MT101FilePath);
                Error('%1', GetLastErrorText());
            end else begin
                SwiftFile.Close();
                FileInfo2 := FileInfo.FileInfo(MT101FilePath);
                FileInfo2.IsReadOnly(TRUE);
                if TempPaymentJournal.FindSet() then
                    repeat
                        PaymentJournal.Copy(TempPaymentJournal);
                        PaymentJournal."Exported to Payment File" := true;
                        PaymentJournal."File Exported Path" := MT101FilePath;
                        PaymentJournal.Modify();

                        VendorLrec.Get(PaymentJournal."Account No.");
                        VendorBankAccountLRec.Get(VendorLrec."No.", VendorLrec."Preferred Bank Account Code");

                        VendorLedger.Reset();
                        VendorLedger.SetRange("Vendor No.", TempPaymentJournal."Account No.");
                        VendorLedger.SetRange("Applies-to ID", PaymentJournal."Document No.");
                        if VendorLedger.FindSet() then begin
                            repeat
                                MT101LogEntry.CreateNew(MT101LogReg."No.",
                                                        0,
                                                        PaymentJournal."Account Type",
                                                        PaymentJournal."Account No.",
                                                        VendorLedger."Entry No.",
                                                        PaymentJournal."Posting Date",
                                                        PaymentJournal."Currency Code",
                                                        PaymentJournal.Amount,
                                                        PaymentJournal."Document No.",
                                                        VendorBankAccountLRec."Bank Account No.",
                                                        PaymentJournal."Message to Recipient");
                            until VendorLedger.Next() = 0;
                        end else begin
                            VendorLedger.SetRange("Applies-to ID");
                            VendorLedger.SetRange("Document No.", PaymentJournal."Applies-to Doc. No.");
                            if VendorLedger.FindSet() then
                                repeat
                                    MT101LogEntry.CreateNew(MT101LogReg."No.",
                                                            0,
                                                            PaymentJournal."Account Type",
                                                            PaymentJournal."Account No.",
                                                            VendorLedger."Entry No.",
                                                            PaymentJournal."Posting Date",
                                                            PaymentJournal."Currency Code",
                                                            PaymentJournal.Amount,
                                                            PaymentJournal."Document No.",
                                                            VendorBankAccountLRec."Bank Account No.",
                                                            PaymentJournal."Message to Recipient");
                                until VendorLedger.Next() = 0;
                        end;
                    until TempPaymentJournal.Next() = 0;
            end;
            GenerateCheckSumFile(MT101FilePath);
            Message('File Exported Successfully');
        end;
    end;

    local procedure ClearGlobals()
    begin
        clear(AccNo);
        Clear(BalAccNo);
        Clear(MT101FilePath);
        Clear(MT101FileName);
    end;

    local procedure CheckMT101Setup()
    begin
        Mt101SFTPSetup.Get();
        Mt101SFTPSetup.TestField("Unique Identifier");
        Mt101SFTPSetup.TestField("PutFile Local Path");
        //Mt101SFTPSetup.TestField("PutFile SFTP Path");
        Mt101SFTPSetup.TestField(FileName);
        Mt101SFTPSetup.TestField(FileExtension);
        Mt101SFTPSetup.TestField("Logical Terminal Address");
        Mt101SFTPSetup.TestField(BIC);
        Mt101SFTPSetup.TestField("Send CheckSum Email To");
    end;

    [TryFunction]
    procedure GenerateMT101File(var FilePath: text)
    begin
        case TempPaymentJournal."Account Type" of
            TempPaymentJournal."Account Type"::Vendor:
                AccNo := TempPaymentJournal."Account No.";
            TempPaymentJournal."Account Type"::"Bank Account":
                BalAccNo := TempPaymentJournal."Account No.";
        end;
        case TempPaymentJournal."Bal. Account Type" of
            TempPaymentJournal."Bal. Account Type"::Vendor:
                AccNo := TempPaymentJournal."Bal. Account No.";
            TempPaymentJournal."Bal. Account Type"::"Bank Account":
                BalAccNo := TempPaymentJournal."Bal. Account No.";
        end;
        BankAccount.Get(BalAccNo);
        BankAccount.TestField("SWIFT Code");
        BasicHeaderBlock(BankAccount."SWIFT Code");
        ApplicationHeaderBlock();
        UserHeaderBlock();
        BodyBlock();
        repeat
            TransactionInfoBlock(TempPaymentJournal);
        until TempPaymentJournal.Next() = 0;
        TrailerBlock();
    end;

    local procedure BasicHeaderBlock(SWIFTCode: Code[20])
    var
        BasicText: Text;
    begin
        BasicText := '{1:F01';
        BasicText += SWIFTCode + 'AXXX0000000000' + '}';
        WriteToStream(BasicText, false);
    end;


    local procedure ApplicationHeaderBlock()
    var
        ApplicationDetail: Text;
        TimeText: Text;
        DateText: Text;
    begin
        ApplicationDetail := '{2:O101';
        TimeText := Format(Time, 0, '<Hours24,2><Filler Character,0><Minutes,2>');
        DateText := Format(today);
        DateText := DELCHR(DateText, '=', '/\-_*^@');
        ApplicationDetail += TimeText + DateText + RemoveSpclChar(Mt101SFTPSetup."Logical Terminal Address") + DateText + TimeText + 'N';
        ApplicationDetail += '}';
        WriteToStream(ApplicationDetail, false);
    end;


    local procedure UserHeaderBlock()
    var
        UserHeader: Text;
        UserLRec: Record User;
    begin
        UserLRec.Reset();
        UserLRec.SetRange("User Name", UserId);
        if UserLRec.FindFirst() then
            UserHeader := '{3:{108:' + RemoveSpclChar(UserLRec."Full Name") + '}}';
        WriteToStream(UserHeader, false);
    end;


    local procedure BodyBlock()
    var
        BodyText: Text;
    begin
        BodyText := '{4:';
        WriteToStream(BodyText, true);
        GeneralInfoBlock();
    end;


    local procedure GeneralInfoBlock()
    var
        CompanyInfo: Record "Company Information";
        ExecutionDate: Text;
    begin
        CompanyInfo.get();
        WriteToStream(':20:' + format(Mt101SFTPSetup."Unique Identifier"), true);
        //WriteToStream(':21R:comm', true);
        WriteToStream(':28D:1/1', true);
        BankAccount.TestField("Bank Account No.");
        WriteToStream(':50H:/' + BankAccount."Bank Account No.", true);
        WriteToStream(copystr(RemoveSpclChar(CompanyInfo.Name), 1, 35), true);
        WriteToStream(copystr(RemoveSpclChar(CompanyInfo.Address), 1, 35), true);
        WriteToStream(copystr(RemoveSpclChar(CompanyInfo."Address 2"), 1, 35), true);
        if CountyGRec.Get(CompanyInfo."Country/Region Code") then;
        WriteToStream(CopyStr(CompanyInfo.City + ',' + CountyGRec.Name, 1, 35), true);
        WriteToStream(':52A:' + 'A', true);
        ExecutionDate := Format(Today, 0, '<Year,2><Month,2><Day,2>');
        ExecutionDate := DELCHR(ExecutionDate, '=', '/\-_*^@');
        WriteToStream(':30:' + ExecutionDate, true);

    end;

    local procedure TransactionInfoBlock(var PaymentJournal: Record "Gen. Journal Line")
    var
        GLSetup: Record "General Ledger Setup";
        AmountText: Text;
        Vendor: Record Vendor;
        VendorLedger: Record "Vendor Ledger Entry";
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        with PaymentJournal do begin
            WriteToStream(':21:' + RemoveSpclChar(PaymentJournal."Document No."), true);
            GLSetup.Get();
            if PaymentJournal."Currency Code" = '' then begin
                AmountText := GLSetup."LCY Code";
            end else
                AmountText := PaymentJournal."Currency Code";
            AmountText += ConvertStr(format(Abs(PaymentJournal.Amount), 0, '<Precision,2:2><Standard Format,2>'), '.', ',');
            WriteToStream(':32B:' + AmountText, true);
            Vendor.Get(PaymentJournal."Account No.");
            Vendor.TestField("Preferred Bank Account Code");
            Vendor.TestField(Name);
            Vendor.TestField(Address);
            Vendor.TestField(City);
            VendorBankAccount.Get(Vendor."No.", Vendor."Preferred Bank Account Code");
            //VendorBankAccount.Get(Vendor."No.", PaymentJournal."Recipient Bank Account");
            VendorBankAccount.TestField(VendorBankAccount."SWIFT Code");
            VendorBankAccount.TestField(VendorBankAccount."Bank Account No.");
            WriteToStream(':57A:' + VendorBankAccount."SWIFT Code", true);
            WriteToStream(':59:/' + VendorBankAccount."Bank Account No.", true);
            WriteToStream(copystr(RemoveSpclChar(Vendor.Name), 1, 35), true);
            WriteToStream(copystr(RemoveSpclChar(Vendor.Address), 1, 35), true);
            if Vendor."Address 2" <> '' then
                WriteToStream(copystr(RemoveSpclChar(Vendor."Address 2"), 1, 35), true);
            if CountyGRec.Get(Vendor."Country/Region Code") then;
            WriteToStream(copystr(Vendor.City + ',' + CountyGRec.Name, 1, 35), true);
            if PaymentJournal."Message to Recipient" <> '' then
                WriteToStream(':70:' + PaymentJournal."Message to Recipient", true);

            /*
            VendorLedger.Reset();
            VendorLedger.SetRange("Vendor No.", Vendor."No.");
            VendorLedger.SetRange("Document No.", PaymentJournal."Applies-to Doc. No.");
            if VendorLedger.FindFirst() then begin
                if VendorLedger."Document Type" = VendorLedger."Document Type"::Invoice then
                    WriteToStream('/INV/' + VendorLedger."Document No.", true);
            end; */
            WriteToStream(':71A:OUR', true);
        end;
    end;

    local procedure TrailerBlock()
    var
        myInt: Integer;
    begin
        WriteToStream('-}', false);
        //WriteToStream('{5:{CHK:74D51B320260}}', true);
    end;

    local procedure WriteToStream(WriteText: Text; NextLine: Boolean)
    var
        myInt: Integer;
    begin
        SwiftOutStream.WriteText(WriteText);
        if NextLine then
            SwiftOutStream.WriteText();
    end;

    local procedure GenerateCheckSumFile(MT101File: Text): Boolean
    var
        CheckSumTempFile: Text;
        CheckSumOutput: Text;
        ServerFileName: Text;
    begin
        ServerFileName := FileMgt.ServerTempFileName('.txt');
        Checksum := Checksum.CheckSum;
        CheckSumTempFile := Checksum.CreateChecksumFile(MT101File, ServerFileName);
        CheckSumOutput := CheckSum.Computesha3CheckSum(CheckSumTempFile);
        ExportCheckSum(CheckSumOutput);
    end;

    local procedure ExportCheckSum(InputText: Text): Boolean
    var
        Path: Text;

    begin
        Path := Mt101SFTPSetup."PutFile Local Path" + '001' + '-' + MT101FileName + Mt101SFTPSetup.FileExtension;
        Clear(SwiftFile);
        SwiftFile.Create(Path);
        SwiftFile.CreateOutStream(SwiftOutStream);
        SwiftOutStream.WriteText(InputText);
        SwiftFile.Close();
        SendMail(Path, '001' + '-' + MT101FileName + Mt101SFTPSetup.FileExtension);
    end;

    LOCAL Procedure GetPutFileName(): Text
    var
        Directory: DotNet Directory;
        FilterString: Text;
        SearchOption: DotNet SearchOption;
        FilePath: Text;
        SrNo: Integer;
    begin
        Mt101SFTPSetup.TESTFIELD("PutFile Local Path");

        FilterString := STRSUBSTNO(Mt101SFTPSetup.FileName + '%1', '*');

        SrNo := Directory.GetFiles(Mt101SFTPSetup."PutFile Local Path", FilterString, SearchOption.TopDirectoryOnly).Length;

        SrNo += 1;
        MT101FileName := Mt101SFTPSetup.FileName + '-' + Mt101SFTPSetup.BIC + '-' +
        FORMAT(Today, 0, '<YEAR4><MONTH,2><DAY,2>') + '-' + '00' + Format(SrNo);
        FilePath := Mt101SFTPSetup."PutFile Local Path" + MT101FileName + Mt101SFTPSetup.FileExtension;


        exit(FilePath);
    end;

    local procedure RemoveSpclChar(String: text): text
    var
        myInt: Integer;
    begin
        exit(DelChr(String, '=', ',./?><"'')(-_+=*&^%$#@!{}[]|\'));
    end;

    local procedure SendMail(Attachment: Text; FileName: Text)
    var
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        ServerFileName: Text;
        FileMgt: Codeunit "File Management";
    begin
        if Mt101SFTPSetup."Send CheckSum Email To" = '' then
            exit;
        SMTPSetup.Get();
        SMTPMail.CreateMessage('', SMTPSetup."User ID", Mt101SFTPSetup."Send CheckSum Email To", 'MT101 CheckSum', '', true);
        SMTPMail.AppendBody('<br></br>');
        SMTPMail.AppendBody(Mt101SFTPSetup."CheckSum Mail Body");
        SMTPMail.AppendBody('<br></br>');
        if Exists(Attachment) then begin
            SMTPMail.AddAttachment(Attachment, FileName);
            SMTPMail.Send();
            Message('Mail Sent Successfully');
        end;
    end;
}