tableextension 50101 "AI Language on Sales Header" extends "Sales Header" //MyTargetTableId
{
    fields
    {
        field(50101;"AI Language";Code[10])
        {
            //Caption ='AI Language';
            CaptionML = ENU = 'AI Language',
                        DEU = 'KI Sprache';
            TableRelation = "AI Supported Language";

        }
    }
}

