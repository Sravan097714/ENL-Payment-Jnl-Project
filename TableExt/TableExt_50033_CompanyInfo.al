tableextension 50033 CompanyInfoExt extends "Company Information"
{
    fields
    {
        field(50000; BRN; Code[20]) { }
        field(50001; "VAT Payer Tax"; text[50]) { }
        field(50002; "VAT Payer Full Name"; text[50]) { }
        field(50003; "Mobile Number"; text[50]) { }
        field(50004; "Name of Declarant"; text[100]) { }
        field(50005; "MRA VAT Email Address"; Text[100]) { }
    }
}