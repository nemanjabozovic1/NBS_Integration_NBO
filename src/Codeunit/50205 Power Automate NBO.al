/// <summary>
/// Codeunit SOAP Service NBO (ID 50201).
/// </summary>
codeunit 50205 "Power Automate NBO"
{
    /// <summary>
    /// SendDataToPowerAutomateFlow
    /// </summary>
    /// <param name="DataP">VAR Text.</param>
    /// <returns>Return variable Response of type Text.</returns>
    procedure SendDataToPowerAutomateFlow(var DataP: Text) Response: Text
    var
        Client: HttpClient;
        Content: HttpContent;
        ResponseMessage: HttpResponseMessage;
    begin
        // Decode the XML document
        DataP := DataP.Replace('&lt;', '   <');
        DataP := DataP.Replace('&gt;', '>   ');

        // Create HttpContent from the JSON text.
        Content.WriteFrom(DataP);

        // Send an HTTP POST request to create a post.
        if not Client.Post('https://prod-183.westeurope.logic.azure.com:443/workflows/eb00a3d459344ad7865135e7d68a5c71/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=WunWt3yNpjsaoddiWU_IUo7RAmrAbD7uHAEv3Nylig0', Content,
                           ResponseMessage) then
            Error('The call to the web service failed.');

        // Check if the response indicates success.
        if not ResponseMessage.IsSuccessStatusCode() then begin
            Error('The web service returned an error message:\\' +
                    'Status code: ' + Format(ResponseMessage.HttpStatusCode()) +
                    'Description: ' + ResponseMessage.ReasonPhrase());
        end;
    end;
}



