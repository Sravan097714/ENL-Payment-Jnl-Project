pageextension 50069 PurchOrderExt extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Co&mments")
        {
            action(ClosePO)
            {
                ApplicationArea = All;
                Caption = 'Close';
                Image = CloseDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                ToolTip = 'Will move to PO Closed List';

                trigger OnAction()
                var
                    PurchHdr: Record "Purchase Header";
                begin
                    CurrPage.SetSelectionFilter(PurchHdr);
                    if PurchHdr.FindSet() then
                        repeat
                            PurchHdr.TestField(Status, PurchHdr.Status::Released);
                            PurchHdr.Status := PurchHdr.Status::Closed;
                            PurchHdr.Modify(true);
                        until PurchHdr.Next() = 0;
                end;
            }

        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Status, '<>%1', Rec.Status::Closed);
    end;
}