codeunit 50104 "AL Translator Translate"
{
    //why temporary?
procedure Translate(Text2Translate: record "Text To Translate" temporary)
var
    Handled: Boolean;
begin
    OnBeforeTranslate(Handled, Text2Translate);

    DoTranslate(Handled, Text2Translate);

    OnAfterTranslate(Text2Translate);    
end;

local procedure DoTranslate(var Handled: Boolean; var Text2Translate: Record "Text To Translate" temporary);
    var
        AuthorizationKey: Text;
    begin
        IF Handled THEN
            EXIT;

        GetAuthorizationKey(AuthorizationKey);
        GetTranslationFromAzureTranslateApi(AuthorizationKey, Text2Translate);
    end;

    local procedure GetBaseURLForTranslationService(): Text
    var
    begin
        exit('https://api.cognitive.microsofttranslator.com/')
    end;

    local procedure GetBaseURLForIssueTokenApi(): Text
    var
    begin
        exit('https://api.cognitive.microsoft.com/sts/v1.0/issueToken')
    end;

    local procedure GetQueryURLForTranslationService(): Text
    var
    begin
        exit('translate?api-version=3.0&from=%1&to=%2')
    end;

    local procedure GetAuthorizationKey(var AuthorizationKey: Text)
    begin
        AuthorizationKey := STRSUBSTNO('Bearer %1', GetAccessToken);
    end;


    local procedure GetAzureSubscriptionKey(): Text
    var
      Setup:Record "AI Translator Service Setup";
    begin
        Setup.Get();
        exit(Setup."Azure Key");
    end;

    local procedure GetAccessToken() Token: Text
    var
        RequestMessage: HttpRequestMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;

    begin
        RequestMessage.SetRequestUri(GetBaseURLForIssueTokenApi());
        RequestMessage.Method := 'POST';
        RequestMessage.GetHeaders(Headers);

        Headers.Add('Ocp-Apim-Subscription-Key', GetAzureSubscriptionKey);

        HttpClient.Send(RequestMessage, ResponseMessage);

        if not ResponseMessage.IsSuccessStatusCode then
            error('The web service returned an error message:\\' +
                  'Status code: %1\' +
                  'Description: %2',
                  ResponseMessage.HttpStatusCode,
                  ResponseMessage.ReasonPhrase);

        Content := ResponseMessage.Content;

        Content.ReadAs(Token);

    end;

    local procedure GetTranslationFromAzureTranslateApi(AuthorizationKey: Text; var Text2Translate: Record "Text To Translate" temporary);
    var
        RequestMessage: HttpRequestMessage;
        ContentHeaders: HttpHeaders;
        HttpContent: HttpContent;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;

        ContentTxt: Text;
    begin
        RequestMessage.SetRequestUri(ConstructUriToMakeTranslation(Text2Translate));
        RequestMessage.Method := 'POST';

        HttpContent.WriteFrom(CreateRequestBodyForTranslation(Text2Translate));
        HttpContent.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-type', 'application/json');

        RequestMessage.Content(HttpContent);

        HttpClient.DefaultRequestHeaders.Add('Authorization', AuthorizationKey);
        HttpClient.DefaultRequestHeaders.Add('Accept', 'application/Json');

        HttpClient.Send(RequestMessage, ResponseMessage);

        if not ResponseMessage.IsSuccessStatusCode then
            error('The web service returned an error message:\\' +
                  'Status code: %1\' +
                  'Description: %2',
                  ResponseMessage.HttpStatusCode,
                  ResponseMessage.ReasonPhrase);

        HttpContent := ResponseMessage.Content;

        Text2Translate.TranslationText := ConvertFromJSon(HttpContent);
    end;

    local procedure ConstructUriToMakeTranslation(var Text2Translate: Record "Text To Translate" temporary): Text
    var
    begin
        exit(
            GetBaseURLForTranslationService() +
            StrSubstNo(GetQueryURLForTranslationService(),
                         Text2Translate.FromLanguage,
                         Text2Translate.ToLanguage)
        )
    end;

    local procedure CreateRequestBodyForTranslation(var Text2Translate: Record "Text To Translate"): Text
    var
        RJsonObj: JsonObject;
        RJsonArr: JsonArray;
        RequestBodyConvertedToTxt: Text;
    begin
        RJsonObj.Add('Text', Text2Translate.TextToTranslate);
        RJsonArr.Add(RJsonObj);
        RJsonArr.WriteTo(RequestBodyConvertedToTxt);
        Exit(RequestBodyConvertedToTxt);
    end;

    local procedure ConvertFromJson(HttpContent: HttpContent): Text
    var
        ContentInTextFormat: Text;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        ResultTxt : Text;
    begin
        HttpContent.ReadAs(ContentInTextFormat);

        If not JsonArray.ReadFrom(ContentInTextFormat) then
            error('Invalid response, expected an JSON array as root object');

        JsonArray.Get(0, JsonToken);
        JsonObject := JsonToken.AsObject;

        Exit(SelectJsonValueAsText(JsonObject, '$.translations[0].text'))

    end;

    procedure SelectJsonValueAsText(var JsonObject: JsonObject; Path: text) Value: Text;
    var
        JsonValue: JsonValue;
    begin
        if not SelectJsonValue(JsonObject, Path, JsonValue) then
            EXIT;
        Value := JsonValue.AsText;
    end;

    local procedure SelectJsonValue(var JsonObject: JsonObject; Path: text; var JsonValue: JsonValue): Boolean;
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            exit;
        JsonValue := JsonToken.AsValue;
        Exit(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTranslate(var Handled: Boolean; var Text2Translate: Record "Text To Translate" temporary);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTranslate(var Text2Translate: Record "Text To Translate" temporary);
    begin
    end;
}