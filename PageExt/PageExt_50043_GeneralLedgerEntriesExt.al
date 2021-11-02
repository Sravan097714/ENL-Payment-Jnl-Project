pageextension 50043 GeneralLedgerEntriesExt extends 20
{
    layout
    {
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }

        addafter("Entry No.")
        {
            field("SourceCode"; "Source Code")
            {
                ApplicationArea = all;
            }
            field("Source Type"; "Source Type")
            {
                ApplicationArea = all;
            }
            field("Source No."; "Source No.")
            {
                ApplicationArea = all;
            }
            field(vendorname; vendorname) { ApplicationArea = all; Editable = false; }
            field("UserID"; "User ID")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Document No."; "External Document No.")
    }


    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        vendorrec: Record Vendor;
        customerrec: Record Customer;


    begin
        Clear(vendorname);
        if Rec."Source Type" = "Source Type"::Vendor then begin
            vendorrec.Reset();
            vendorrec.SetRange("No.", "Source No.");
            if vendorrec.FindFirst then
                vendorname := vendorrec.Name;
        end
        else
            if rec."Source Type" = "Source Type"::Customer then begin
                customerrec.Reset();
                customerrec.SetRange("No.", "Source No.");
                if customerrec.FindFirst then
                    vendorname := customerrec.Name;

            end
            else
                vendorname := '';




    end;

    var
        vendorname: Text;
        customername: Text;
}