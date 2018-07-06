codeunit 50101 "AI Language Subscriber"
{

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Bill-to Customer No.', true, true)]
    local procedure FillAILanguageIfLanguageIsSet(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
        Language: Record Language;
        Handled: Boolean;
    begin
        GetCustomer(Rec, Customer, Handled);
        GetCustomerLanguage(Customer, Language, Handled);
        AssignCustomerAILanguageToSalesHeader(Rec, Language, Handled);
    end;

    local procedure GetCustomer(SalesHeader: Record "Sales Header"; var Customer: Record Customer; var Handled: Boolean)
    begin
        if Handled then
            exit;

        if not Customer.get(SalesHeader."Sell-to Customer No.") then
            Handled := true;
    end;

    local procedure GetCustomerLanguage(Customer: Record Customer; var Language: Record Language; var Handled: Boolean)
    begin
        if Handled then
            exit;

        if Customer."Language Code" = '' then begin
            Handled := true;
            exit;
        end;

        if not Language.get(Customer."Language Code") then
            Handled := true;
    end;

    local procedure AssignCustomerAILanguageToSalesHeader(var SalesHeader: Record "Sales Header"; Language: Record Language; var Handled: Boolean)
    begin
        if Handled then
            exit;
        
        if Language."AI Language" = '' then
            exit;
        
        SalesHeader."AI Language" := Language."AI Language";
        SalesHeader.MODIFY;
    end;

}