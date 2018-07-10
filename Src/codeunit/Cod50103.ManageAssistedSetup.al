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

    [EventSubscriber(ObjectType::Table, database::"Aggregated Assisted Setup", 'OnUpdateAssistedSetupStatus', '', false, false)]
    local procedure UpdateAITranslatorSetupInAssistedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup")
    var 
        Status: Boolean;
        MyAppStatus: Record "AI Translator Service Setup";
    begin
        MyAppStatus.Get();
        Status := MyAppStatus."Azure Key" <> '';
        case Status of
            false:
                TempAggregatedAssistedSetup.SetStatus(TempAggregatedAssistedSetup,Page::"AI Translator Setup Wizard", TempAggregatedAssistedSetup.Status::"Not Completed");
            true:
                TempAggregatedAssistedSetup.SetStatus(TempAggregatedAssistedSetup,Page::"AI Translator Setup Wizard", TempAggregatedAssistedSetup.Status::Completed);
        end;
    end;
}