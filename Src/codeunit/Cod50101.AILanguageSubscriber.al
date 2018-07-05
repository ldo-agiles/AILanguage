codeunit 50101 "AI Language Subscriber"
{
    var Customer :Record Customer;
        AILanguage :Record "AI Supported Language";
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Bill-to Customer No.', true, true)]
    local procedure FillAILanguageIfLanguageIsSet(var Rec: Record "Sales Header")
    begin
        if Customer.Get(Rec."Bill-to Customer No.") then begin
            if AILanguage.Get(Customer."Language Code") then begin
                Rec."AI Language" := AILanguage."Code";
                Rec.Modify();
            end;
        end;
    end;
}