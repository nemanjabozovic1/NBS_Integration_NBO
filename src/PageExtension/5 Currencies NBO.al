
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
                    ResponseL := CallSOAPService.CallSOAPService();

                    // Optionally display of the response (for testing purposes of XML buffer table) | 2 way
                    // TempXMLBuffer.Run();
                end;
            }
        }
    }

    var
        CallSOAPService: Codeunit "SOAP Service NBO";
        TempXMLBuffer: Codeunit "XML Buffer NBO";
}