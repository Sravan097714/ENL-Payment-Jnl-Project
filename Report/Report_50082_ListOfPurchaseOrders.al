//LS
report 50082 "List of Purchase Orders"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = filter(Order));
            column(No_; 'Po No.') { }
            column(Buy_from_Vendor_No_; 'Supplier No.') { }
            column(Buy_from_Vendor_Name; 'Supplier Name') { }
            column(Document_Date; "Document Date") { }
            column(Posting_Date; "Posting Date") { }
            column(Status; Status) { }
            column(Amount_Including_VAT; "Amount Including VAT") { }

            trigger OnPreDataItem()
            begin
                Window.OPEN('Purchase No. : #1##########');
                MakeExcelDataHeader;
            end;

            trigger OnAfterGetRecord()
            begin
                Window.Update(1, "Purchase Header"."No.");
                Month := FORMAT(DATE2DMY(EndingDate, 2));
                Year := FORMAT(DATE2DMY(EndingDate, 3));

                clear(quantitysum);
                clear(Qtytoreceive);
                clear(amttoreceive);
                Clear(qtyreceived);
                Clear(amtreceived);
                grecPurchLine.Reset();
                grecPurchLine.SetCurrentKey("Document Type", "Document No.", "Line No.");
                grecPurchLine.SetRange("Document No.", "Purchase Header"."No.");
                if grecPurchLine.FindFirst() then begin
                    repeat
                        quantitysum += grecPurchLine.Quantity;
                        Qtytoreceive += grecPurchLine."Qty. to Receive";
                        amttoreceive += (grecPurchLine."Qty. to Receive" * grecPurchLine."Direct Unit Cost");
                        qtyreceived += grecPurchLine."Quantity Received";
                        amtreceived += (grecPurchLine."Quantity Received" * grecPurchLine."Direct Unit Cost");
                    until grecPurchLine.Next = 0;
                end;
                CreateExcelData;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(StartingDate; StartingDate)
                {
                    Caption = 'Starting Date';
                    ApplicationArea = All;
                }
                field(EndingDate; EndingDate)
                {
                    Caption = 'Ending Date';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }


    labels
    {
    }
    trigger OnPreReport()
    begin
        ExcelBuf.DeleteAll();


    end;

    trigger OnPostReport()
    begin
        CreateExcelBook;
    end;

    var

        StartingDate: Date;
        EndingDate: Date;
        VarDesc: Text[50];
        VarAmtExclVAT: Decimal;
        VarVATAmt: Decimal;
        VarInvoiceNo: Text[50];
        VarName: Text[50];
        VarPaidAmt: Decimal;
        Window: Dialog;
        Text000: Label 'Reading Purchase No    #1##########';
        ExcelBuf: Record "Excel Buffer" temporary;
        Month: Text;
        Year: Text;
        DocNo: Code[20];
        TTBASE: Decimal;
        TTAMT: Decimal;

        purchaselinerec: Record "Purchase Line";
        quantitysum: Decimal;
        Qtytoreceive: Decimal;
        amttoreceive: Decimal;
        amtreceived: Decimal;
        qtyreceived: Decimal;



        grecPurchLine: Record "Purchase Line";








    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn('PO No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Supplier Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Purchase Order Amount Incl. VAT', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Qty to receive', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount to receive', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity Received', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount Received', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure CreateExcelData()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Purchase Header"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purchase Header"."Buy-from Vendor No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purchase Header"."Buy-from Vendor Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purchase Header"."Document Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purchase Header"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Purchase Header".Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(quantitysum, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Purchase Header"."Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Qtytoreceive, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(amttoreceive, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(qtyreceived, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(amtreceived, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);


    end;

    local procedure CreateExcelBook()
    begin
        ExcelBuf.CreateBookAndOpenExcel('', 'List of Purchase Orders', '', COMPANYNAME, USERID);

    end;



}

