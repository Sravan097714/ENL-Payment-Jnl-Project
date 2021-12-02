report 50092 WinSCPTest
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FilePath; FilePath)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }
    trigger OnPreReport()
    begin
        if FilePath = '' then
            Error('Please give file path');
        WinSFTP.PutFile(FilePath);
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Done');
    end;

    var
        WinSFTP: Codeunit "WinSFTP Processing";
        FilePath: Text;

}