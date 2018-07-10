tableextension 50104 "AILanguageTranslateOnSalesLine" extends "Sales Line" //MyTargetPageId
{
    var 
        Text2Translate: Record "Text To Translate";
        SalesHeader: Record "Sales Header";
        AITranslator: Codeunit "AI Translator Translate";
    procedure TranslateLine()
    begin
        if not SalesHeader.Get("Document Type","No.") then
            Error('There is no Header for this line...');

        Text2Translate.Init();
        Text2Translate.TextToTranslate := Description;
        Text2Translate.FromLanguage := 'de';
        Text2Translate.ToLanguage := SalesHeader."AI Language";
        
        AITranslator.Translate(Text2Translate);
        Description := Text2Translate.TranslationText;
    end;
}