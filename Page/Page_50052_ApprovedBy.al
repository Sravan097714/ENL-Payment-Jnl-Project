page 50052 "Approved By Factbox"
{
    Caption = 'Approved By';
    PageType = CardPart;
    SourceTable = "Posted Approval Entry";
    SourceTableView = where(Status = filter(Approved));
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;


                field("Approver ID"; "Approver ID")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field(Name; name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approved Date"; "Last Date-Time Modified")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Date';
                }



            }

        }
    }

    actions
    {
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin
    end;

    trigger OnAfterGetRecord()
    var
        //currentFilterGroup: Integer;
        userrec: Record user;

    begin
        /*currentFilterGroup := FilterGroup;
        FilterGroup := 4;

        NumberOfRecords := 0;
        if GetFilters() <> '' then
            NumberOfRecords := Count;
        FilterGroup := currentFilterGroup;
        */
        clear(name);
        userrec.Reset();
        userrec.SetRange("User Name", "Approver ID");
        if userrec.FindSet then
            name := userrec."Full Name";
    end;

    var
        NumberOfRecords: Integer;
        name: Text[250];
}

