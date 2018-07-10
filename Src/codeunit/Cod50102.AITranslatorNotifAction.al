codeunit 50102 "AI Translator Notif. Action"
{
    procedure Setup(TheNotification: Notification)
    begin
        Page.RunModal(50103);
        
    end;
}