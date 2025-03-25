codeunit 50201 "SOAP Service NBO"
{
    procedure CallSOAPService() Response: Text
    var
        HttpClientL: HttpClient;
        HttpContentL: HttpContent;
        HttpHeadersL: HttpHeaders;
        HttpResponseL: HttpResponseMessage;
        RequestBodyL: Text;
        ResponseTextL: Text;
        UrlL: Text;
    begin
        // Get dynamic request body
        RequestBodyL := DynamicRequestBody();

        // Get dynamic URL
        UrlL := DynamicUrlEndpoint();

        // Set the content type to text/xml
        HttpContentL.WriteFrom(RequestBodyL);
        HttpContentL.GetHeaders(HttpHeadersL);
        HttpHeadersL.Clear();
        HttpHeadersL.Add('Content-Type', 'text/xml; charset=utf-8');

        // Send the SOAP request
        if not HttpClientL.Post(UrlL, HttpContentL, HttpResponseL) then
            Error('Failed to call SOAP service.');

        // Check if the response is successful
        if not HttpResponseL.IsSuccessStatusCode then
            Error('SOAP service returned an error: %1', HttpResponseL.ReasonPhrase);

        // Read the response content
        HttpResponseL.Content.ReadAs(ResponseTextL);

        // Process the XML response
        XMLtoJSON.ReadXml(ResponseTextL);

        // Return the response text (if needed)
        // exit(ResponseTextL);
    end;

    local procedure DynamicRequestBody() ReturnBody: Text
    var
        UserNameL: Text;
        PasswordL: Text;
        LicenceIDL: Text;
        RequestBodyL: Text;
        SoapBodyL: Text;
        NBSSetupL: Record "NBS Setup NBO";
    begin
        // Get credentials from the setup table
        if not NBSSetupL.FindSet() then
            Error('NBS Setup record not found.');

        if NBSSetupL.UserName = '' then
            Error('The Username is empty.');
        UserNameL := NBSSetupL.UserName;

        if NBSSetupL.Password = '' then
            Error('The Password is empty.');
        PasswordL := NBSSetupL.Password;

        if NBSSetupL.LicenceId = '' then
            Error('The Licence Id is empty.');
        LicenceIDL := NBSSetupL.LicenceId;

        // Define the SOAP body (dynamic part)
        SoapBodyL := '<GetCurrentExchangeRate xmlns="http://communicationoffice.nbs.rs">' +
                     '   <exchangeRateListTypeID>3</exchangeRateListTypeID>' +
                     '</GetCurrentExchangeRate>';

        // Define the full SOAP request body
        RequestBodyL := '<?xml version="1.0" encoding="utf-8"?>' +
                        '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tns="http://communicationoffice.nbs.rs" xmlns:s1="http://microsoft.com/wsdl/types/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/">' +
                        '  <soap:Header>' +
                        '    <AuthenticationHeader xmlns="http://communicationoffice.nbs.rs">' +
                        '      <UserName>' + UserNameL + '</UserName>' +
                        '      <Password>' + PasswordL + '</Password>' +
                        '      <LicenceID>' + LicenceIDL + '</LicenceID>' +
                        '    </AuthenticationHeader>' +
                        '  </soap:Header>' +
                        '  <soap:Body>' +
                        SoapBodyL +
                        '  </soap:Body>' +
                        '</soap:Envelope>';

        exit(RequestBodyL);
    end;

    local procedure DynamicUrlEndpoint() ReturnUrl: Text
    var
        BaseL: Text;
        ExchangeRateXmlServiceL: Text;
        UrlL: Text;
    begin
        // Define the base URL and service endpoint
        BaseL := 'https://webservices.nbs.rs/CommunicationOfficeService1_0/';
        ExchangeRateXmlServiceL := 'ExchangeRateXmlService.asmx';
        UrlL := BaseL + ExchangeRateXmlServiceL;

        // Validate the URL
        if UrlL = '' then
            Error('Empty URL.');

        exit(UrlL);
    end;

    var
        XMLtoJSON: Codeunit "XML Reader NBO";
}