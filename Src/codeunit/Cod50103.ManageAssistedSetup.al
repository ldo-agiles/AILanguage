codeunit 50103 "ManageAssistedSetup"
{
    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', false, false)]
    local procedure RegisterAITranslatorSetupInAssistedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup")
    var 
        MyAppSetup: Record "AI Translator Service Setup";
    begin
        MyAppSetup.InsertIfNotExists();
        MyAppSetup.Get();

        TempAggregatedAssistedSetup.AddExtensionAssistedSetup(50103,'Setup AI Language Translator', true, MyAppSetup.RecordId(),0,'');
    end;
}