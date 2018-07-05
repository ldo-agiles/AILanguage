table 50101 "AI Supported Language"
{
    DataClassification = CustomerContent;
    Caption = 'AI Supported Language';
    
    fields
    {
        field(1;"Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2;Description;Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    
}