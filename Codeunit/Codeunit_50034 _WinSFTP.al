codeunit 50034 "WinSFTP Processing"
{

    var
        WinSCPSesh: DotNet WinSCPSessionDll;

        WinSCPSessionOptions: DotNet WinSCPSessionOptionsDll;

        WinSCPTransferOptions: DotNet WinSCPTransferOptionsDll;

        WinSCPTransferResults: DotNet WinSCPTransferOperationResultDll;

        WinSCPTransferResumeSupport: DotNet WinSCPTransferResumeSupportDll;

        WinSCPTtransferResumeSupportState: DotNet WinSCPTransferResumeSupportStateDll;

        MoveFileDotNet: DotNet FileDotnet;

        WinSCPProtocol: DotNet WinSCPProtocolDll;

        WinSCPRemoteInfoColl: DotNet WinSCPRemoteDirectoryInfoDll;

        WinSCPRemoteInfo: DotNet WinSCPRemoteFileInfoDll;

        DirectoryCheck: DotNet Directory;
        Winscp_Execuitable_path: Label 'C:\Program Files (x86)\WinSCP\WinSCP.exe';
        FileRec: Record File;
        FileManagement: Codeunit "File Management";
        FilePathNameGVar: Text[250];
        FileNameGVar: Text[100];
        varXmlFile: File;
        varOutputStream: OutStream;
        Selection: Integer;
        FileName: Text[250];
        MT101SFTPSetup: Record "MT101 SFTP Setup";

    procedure PutFile(FileNameLPar: Text[100]): Boolean

    begin
        if FileNameLPar = '' then
            exit(false);
        MT101SFTPSetup.GET();

        WinSCPSessionOptions := WinSCPSessionOptions.SessionOptions();

        WinSCPSessionOptions.Protocol := WinSCPProtocol.Sftp;

        WinSCPSessionOptions.HostName := MT101SFTPSetup."Host Name";

        WinSCPSessionOptions.PortNumber := MT101SFTPSetup."Port Number";

        WinSCPSessionOptions.UserName := MT101SFTPSetup."User Name";

        WinSCPSessionOptions.SshPrivateKeyPath := 'C:\WINSCP\MCBSFTPPrivateKey.ppk';

        WinSCPSessionOptions.Password := MT101SFTPSetup.Password;

        WinSCPSessionOptions.GiveUpSecurityAndAcceptAnySshHostKey := true;

        WinSCPSesh := WinSCPSesh.Session();
        WinSCPSesh.ExecutablePath(Winscp_Execuitable_path);
        WinSCPSesh.Open(WinSCPSessionOptions);
        IF WinSCPSesh.Opened THEN BEGIN
            WinSCPTransferOptions := WinSCPTransferOptions.TransferOptions;
            WinSCPTransferOptions.TransferMode := 0;
            WinSCPTransferResumeSupport := WinSCPTransferOptions.ResumeSupport;
            WinSCPTransferResumeSupport.State(WinSCPTtransferResumeSupportState.Off);
            /*
            WinSCPTransferResults := WinSCPSesh.PutFiles('C:\MCB101\Payment Files\enltest3.pdf',
                                     WinSCPSesh.HomePath() + '/ToMCB/MT101-ENLIMUMU/Deposit/',
                                     FALSE,
                                     WinSCPTransferOptions);
            */
            if Exists(FileNameLPar) then
                WinSCPTransferResults := WinSCPSesh.PutFiles(FileNameLPar,
                                         WinSCPSesh.HomePath() + MT101SFTPSetup."PutFile SFTP Path",
                                         FALSE,
                                         WinSCPTransferOptions)

            else
                Error('File does not exist %1', FileNameLPar);

            if WinSCPTransferResults.IsSuccess then begin
                COPY(FileNameLPar, MT101SFTPSetup."Archive Local Path" + FileManagement.GetFileName(FileNameLPar));
                Erase(FileNameLPar);
            end;
            exit(true);
        END;
        exit(false);
    end;
}

