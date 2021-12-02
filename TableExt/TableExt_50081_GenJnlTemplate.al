tableextension 50080 GenJnlTemplateExt extends "Gen. Journal Template"
{
    fields
    {
        // Add changes to table fields here
        field(50000; MT101; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}