table 50032 "Approval Route"
{
    fields
    {
        field(1; Code; Code[20]) { }
        field(2; Description; Text[250]) { }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}