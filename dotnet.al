dotnet
{

    assembly("mscorlib")
    {
        type("System.Collections.Generic.List`1"; "List_Of_T")
        {
        }

        type("System.Reflection.MethodInfo"; "S4L MethodInfo")
        {
        }

        type("System.Object"; "S4L Object")
        {
        }

        type("System.Type"; "S4L Type")
        {
        }

        type("System.Array"; "S4L Array")
        {
        }

        type("System.IO.MemoryStream"; "S4L MemoryStream")
        {
        }

        type("System.Activator"; "S4L Activator")
        {
        }

        type("System.Enum"; "S4L Enum")
        {
        }

        type("System.Convert"; "S4L Convert")
        {
        }

        type("System.Environment"; "S4L Environment")
        {
        }

        type("System.Security.Cryptography.FromBase64Transform"; "FromBase64Transform")
        {
        }

        type("System.Security.Cryptography.FromBase64TransformMode"; "FromBase64TransformMode")
        {
        }

        type("System.Byte"; "Byte")
        {
        }

        type("System.Text.Encoding"; "Encoding")
        {
        }

        type("System.IO.FileStream"; "FileStream")
        {
        }

        type("System.IO.FileMode"; "FileMode")
        {
        }

        type("System.IO.FileAccess"; "FileAccess")
        {
        }

        type("System.Security.SecurityElement"; "SecurityElement")
        {
        }

        type("System.IO.Stream"; "Stream")
        {
        }
        /*
        type("System.IO.IsolatedStorage.IsolatedStorageSecurityOptions"; "IsolatedStorageSecurityOptions")
        {
        }
        */

        type("System.IO.StreamWriter"; "StreamWriter")
        {
        }
        type("System.IO.File"; "File")
        {
        }

        type(System.IO.FileInfo; FileInfo) { }


    }
    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.IO.Path"; "S4L Path")
        {
        }

        type("System.IO.Directory"; "S4L Directory")
        {
        }

        type("System.String"; "S4L String")
        {
        }
        type(System.IO.Directory; Directory)
        {
        }
        type(System.IO.SearchOption; SearchOption)
        { }
        type(System.IO.File; FileDotnet)
        { }
    }

    assembly("MCB.DataProcessing")
    {
        Version = '1.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';
        type(MCBDataProcessing.CheckSum; CheckSum)
        {

        }

    }
    assembly(WinSCPnet)
    {
        Version = '1.8.3.11829';
        Culture = 'neutral';
        PublicKeyToken = '2271ec4a3c56d0bf';
        type(WinSCP.Session; WinSCPSessionDll) { }
        type(WinSCP.SessionOptions; WinSCPSessionOptionsDll) { }
        type(WinSCP.TransferOptions; WinSCPTransferOptionsDll) { }
        type(WinSCP.TransferOperationResult; WinSCPTransferOperationResultDll) { }
        type(WinSCP.TransferResumeSupport; WinSCPTransferResumeSupportDll) { }
        type(WinSCP.TransferResumeSupportState; WinSCPTransferResumeSupportStateDll) { }
        type(WinSCP.Protocol; WinSCPProtocolDll) { }
        type(WinSCP.RemoteDirectoryInfo; WinSCPRemoteDirectoryInfoDll) { }
        type(WinSCP.RemoteFileInfo; WinSCPRemoteFileInfoDll) { }

    }

}
