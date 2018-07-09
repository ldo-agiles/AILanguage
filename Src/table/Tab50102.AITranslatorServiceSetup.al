table 50102 "AI Translator Service Setup"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; URL; Text[250])
        {
            Caption = 'URL';
            
            DataClassification = CustomerContent;
        }
        field(3; "Azure Key"; Text[250])
        {
            Caption = 'Azure Subscription Key';
            
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    
}