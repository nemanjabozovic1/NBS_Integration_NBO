/// <summary>
/// Codeunit XML Collection NBO (ID 50204).
/// </summary>
codeunit 50204 "XML Collection NBO"
{
    /// <summary>
    /// TransformToXmlCollection.
    /// </summary>
    /// <param name="XmlDataP">Text.</param>
    /// <returns>Return variable Response of type Text.</returns>
    procedure TransformToXmlCollection(XmlDataP: Text) Response: Text;
    var
        // XML elements
        XmlDocL: XmlDocument;
        XmlNodeList: XmlNodeList;
        XmlNode: XmlNode;
        ElementL: XmlElement;
        Element2L: XmlElement;
        NodeListL: XmlNodeList;

        // Applicable only for different XML data structure
        // xmlAttribute: XmlAttribute;
        // xmlAttributes: XmlAttributeCollection;

        XmlNamespaceManager: XmlNamespaceManager;

        // Attributes
        CurrencyCodeAlfaChar: Text[50];
        i: Integer;

    begin
        // Message(Format(XmlDataP));

        // Decode the XML document
        XmlDataP := XmlDataP.Replace('&lt;', '   <');
        XmlDataP := XmlDataP.Replace('&gt;', '>   ');

        //Add namespace
        XmlNamespaceManager.AddNamespace('GetCurrentExchangeRateResult', 'http://communicationoffice.nbs.rs');

        // Load the XML data into the XmlDocument
        if not XmlDocument.ReadFrom(XmlDataP, XmlDocL) then begin
            Error('Failed to load XML data.');
        end else begin
            // Try reading documnet
            XmlDocument.ReadFrom(XmlDataP, XmlDocL);

            // Try to get specific nodes
            IF XmlDocL.SelectNodes('//GetCurrentExchangeRateResult:ExchangeRateDataSet', XmlNamespaceManager, XmlNodeList) then begin
                foreach XmlNode in XmlNodeList do begin
                    // Message('%1', XmlNode);
                    Response := XmlNode.AsXmlElement().InnerText();
                    exit(Response);
                    break;
                end;
            end;
        end;
    end;
}