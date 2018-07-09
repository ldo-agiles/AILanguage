pageextension 50103 "AILanguageOnO36Activities" extends "O365 Activities" //MyTargetPageId
{
    layout
    {
        
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        ShowNotification();
    end;
    local procedure ShowNotification()
    var AILanguageNotification: Notification;
    begin
        with AILanguageNotification do begin            
            Id          :=  '2ca1cc8e-a99c-4dce-9b41-0ac3f6e5c1c6';
            Message     :=  'You have new app: AI Translator'; 
            Scope       := NotificationScope::LocalScope; 
            AddAction('Setup',Codeunit::"AI Translator Notif. Action",'Setup');           
            Send;  
        end;
    end;
}


