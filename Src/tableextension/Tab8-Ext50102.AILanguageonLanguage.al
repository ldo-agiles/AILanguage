tableextension 50102 "AI Language on Language" extends "Language" //8
{
    fields
    {
        field(50101;"AI Language";Code[10])
        {
            Caption ='AI Language'; //CaptionML will be depreciated
            TableRelation = "AI Supported Language";
        }
    }
    
}