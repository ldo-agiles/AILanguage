table 50103 "Text To Translate"
{
    DataClassification = CustomerContent;
        
    
    fields
    {
        field(1;TextToTranslate; Text[250])
        {
            Caption = 'TextToTranslate';
            DataClassification = CustomerContent;
        }
        field(2;FromLanguage; Text[250])
        {
            Caption = 'FromLanguage';
            DataClassification = CustomerContent;
        }
        field(3;ToLanguage; Text[250])
        {
            Caption = 'ToLanguage';
            DataClassification = CustomerContent;
        }
        field(4;TranslationText; Text[250])
        {
            Caption = 'TranslationText';
            DataClassification = CustomerContent;
        }
        
    }
    
    keys
    {
        key(PK; TextToTranslate)
        {
            Clustered = true;
        }
    }
    
}