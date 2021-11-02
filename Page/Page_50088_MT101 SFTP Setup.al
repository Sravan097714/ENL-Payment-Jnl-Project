page 50088 "MT101 SFTP Setup"
{
    PageType = Card;
    SourceTable = "MT101 SFTP Setup";
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'ENL - MT101 SFTP Setup';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Host Name"; "Host Name")
                {
                }
                field("Port Number"; "Port Number")
                {
                }
                field("User Name"; "User Name")
                {
                }
                field(Password; Password)
                {
                }
                field("PutFile Local Path"; "PutFile Local Path")
                {
                }
                field("PutFile SFTP Path"; "PutFile SFTP Path")
                {
                }
                field("GetFile Local Path"; "GetFile Local Path")
                {
                }
                field("GetFile SFTP Path"; "GetFile SFTP Path")
                {
                }
                field("Archive SFTP Path"; "Archive SFTP Path")
                {
                }
                field(TLSHostCertificateFingerprint; TLSHostCertificateFingerprint)
                {
                }
                field(FileExtension; FileExtension)
                {
                }
                field(FileName; FileName) { }
                field("Logical Terminal Address"; "Logical Terminal Address") { }
                field(BIC; BIC) { }
                field("Send CheckSum Email To"; "Send CheckSum Email To") { }
                field("Log Path"; "Log Path")
                {
                }
                field("Log Email"; "Log Email")
                {
                }

                field("CheckSum Mail Body"; "CheckSum Mail Body") { MultiLine = true; }
                field("Unique Identifier"; "Unique Identifier") { }
            }
        }
    }

    actions
    {
    }
}

