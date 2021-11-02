//LS
pageextension 50031 VendorCardExt extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field(BRN; Rec.BRN)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    vendorrec.Reset();
                    vendorrec.SetRange(BRN, rec.BRN);
                    if vendorrec.FindFirst() then
                        Error('BRN already used on another customer');
                end;
            }
            field(NID; Rec.NID)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    vendorrec.Reset();
                    vendorrec.SetRange(NID, rec.NID);
                    if vendorrec.FindFirst() then
                        Error('NID already used on another customer');
                end;
            }
            field(VendorBankName; VBAccName)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(VendorBankAccountNumber; VBAccNum)
            {
                ApplicationArea = all;
                Caption = 'Vendor Bank Account No.';
                Editable = false;
            }
            field(VendorBankIBAN; VBAccIBAN)
            {
                ApplicationArea = all;
                Caption = 'Vendor IBAN';
                Editable = false;
            }
            field(VendorBankSwift; VBAccSWIFT)
            {
                ApplicationArea = all;
                Caption = 'Vendor SWIFT Code';
                Editable = false;

            }

        }
        addafter(Name)
        {
            field(PayeeName; PayeeName)
            {
                Caption = 'Payee Name';
            }
        }
        addlast("Address & Contact")
        {
            field("Remittance Email"; "Remittance Email")
            {
                ApplicationArea = all;
            }
            field(Contact2; Contact2)
            {
                ApplicationArea = all;

            }
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("Pay-to Vendor No.")
        {
            Visible = false;
        }
        modify("Invoice Disc. Code")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify(Receiving)
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("No.")
        {
            Editable = false;
        }


    }
    actions
    {
        modify(PayVendor)
        {
            Visible = false;
        }
        modify("Create Payments")
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify(Quotes)
        {
            Visible = false;
        }
        modify(VendorReportSelections)
        {
            Visible = false;
        }
        modify("Cross References")
        {
            Visible = false;
        }
        modify("Blanket Orders")
        {
            Visible = false;
        }
        modify(NewPurchaseQuote)
        {
            Visible = false;
        }
        modify(Flow)
        {
            Visible = false;
        }
        modify("Purchase Journal")
        {
            Visible = false;
        }
        modify(OrderAddresses)
        {
            Visible = false;
        }
        modify(Purchases)
        {
            Visible = false;
        }
        modify(Documents)
        {
            Visible = false;
        }
        modify("Entry Statistics")
        {
            Visible = false;
        }
        modify("Statistics by C&urrencies")
        {
            Visible = false;
        }
        modify("Item &Tracking Entries")
        {
            Visible = false;
        }
    }
    var
        vendorrec: Record Vendor;


}