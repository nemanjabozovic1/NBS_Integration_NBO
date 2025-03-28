/// <summary>
/// PageExtension Currencies NBO (ID 50201) extends Record Currencies.
/// </summary>
pageextension 50201 "Currencies NBO" extends "Currencies"
{
    actions
    {
        addlast(processing)
        {
            action("Exchange Rate Service")
            {
                ApplicationArea = All;
                ToolTip = 'Calls an external Exchange Rate Service to retrieve the latest exchange rates.';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ResponseL: Text;
                begin
                    // Call the SOAP service and retrieve the response and process XML data | 1 way
                    // ResponseL := CallSOAPService.CallSOAPService();

                    // Optionally display of the response (for testing purposes of XML buffer table) | 2 way
                    // TempXMLBuffer.Run();

                    // Try to transform XML data to XML Attrubutes Collection | 3 way
                    // ResponseL := CallSOAPService.CallSOAPService();
                    // XMLCollectionNBO.TransformToXmlCollection(ResponseL);
                    // ResponseL := PowerAutomateNBO.SendDataToPowerAutomateFlow(ResponseL);

                    // Processing XML data in Power Automate | 4 way
                    ResponseL := CallSOAPService.CallSOAPService();
                    // Message(ResponseL);
                    PowerAutomateNBO.SendDataToPowerAutomateFlow(ResponseL);
                end;
            }
        }
    }

    var
        CallSOAPService: Codeunit "SOAP Service NBO";
        TempXMLBuffer: Codeunit "XML Buffer NBO";
        XMLCollectionNBO: Codeunit "XML Collection NBO";
        PowerAutomateNBO: Codeunit "Power Automate NBO";
}