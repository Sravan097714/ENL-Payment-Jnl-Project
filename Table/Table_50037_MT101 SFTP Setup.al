table 50037 "MT101 SFTP Setup"
{
    Caption = 'MT101 SFTP Setup';

    fields
    {
        field(1; "Primay Key"; Code[10])
        {
            Caption = 'Primay Key';
        }
        field(2; "Host Name"; Text[30])
        {
            Caption = 'Host Name';
        }
        field(3; "Port Number"; Integer)
        {
            Caption = 'Port Number';
        }
        field(4; "User Name"; Text[50])
        {
            Caption = 'User Name';
        }
        field(5; Password; Text[50])
        {
            Caption = 'Password';
        }
        field(6; "PutFile Local Path"; Text[100])
        {
            Caption = 'PutFile Local Path';
        }
        field(7; "PutFile SFTP Path"; Text[100])
        {
            Caption = 'PutFile SFTP Path';
        }
        field(8; "GetFile Local Path"; Text[100])
        {
            Caption = 'GetFile Local Path';
        }
        field(9; "GetFile SFTP Path"; Text[100])
        {
            Caption = 'GetFile SFTP Path';
        }
        field(10; "Archive SFTP Path"; Text[100])
        {
            Caption = 'Archive SFTP Path';
        }
        field(11; TLSHostCertificateFingerprint; Text[100])
        {
            Caption = 'TLSHostCertificateFingerprint';
        }
        field(12; FileExtension; Text[5])
        {
            Caption = 'FileExtension';
        }
        field(33; "Journal Template Name"; Code[50])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(34; "Journal Batch Name"; Code[50])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(35; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(36; "Log Path"; Text[250])
        {
            Caption = 'Log Path';
        }
        field(37; "Log Email"; Text[250])
        {
            Caption = 'Log Email';
        }
        field(38; "SkipSame File"; Boolean)
        {
            Caption = 'SkipSame File';
        }
        field(39; FileName; Text[250])
        {
            Caption = 'FileName';
        }
        field(40; "Payment Transmit Path"; Text[250])
        {
            Caption = 'Payment Transmit Path';
        }
        field(41; "Logical Terminal Address"; Text[250])
        {
            Caption = 'Logical Terminal Address';
        }
        field(42; BIC; Text[20])
        {
            Caption = 'BIC';
        }
        field(43; "Send CheckSum Email To"; Text[250])
        {
            Caption = 'Send CheckSum Email To';
        }
        field(44; "CheckSum Mail Body"; Text[250])
        {
            Caption = 'CheckSum Mail Body';
        }
        field(45; "Unique Identifier"; Integer)
        {
            Caption = 'Unique Identifier';
        }
    }

    keys
    {
        key(Key1; "Primay Key")
        {
        }
    }

    fieldgroups
    {
    }
}

