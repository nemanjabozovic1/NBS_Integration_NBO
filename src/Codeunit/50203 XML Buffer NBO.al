/// <summary>
/// Codeunit XML Buffer NBO (ID 50203).
/// </summary>
codeunit 50203 "XML Buffer NBO"
{

    trigger OnRun()
    begin
        ProcessXML();
    end;

    /// <summary>
    /// ProcessXML.
    /// </summary>
    procedure ProcessXML()
    var

        TempXMLBuffer: Record "XML Buffer" temporary;
        XMLBlobNBO: Record "XML Blob NBO" temporary;
        xlInStream: InStream;
        xlFile: Text;


    begin
        XMLBlobNBO.Blob.CreateInStream(xlInStream);
        UploadIntoStream('Choose file', '', '*.xml*|*.*', xlFile, xlInStream);
        TempXMLBuffer.LoadFromStream(xlInStream);
        Page.Run(Page::"XML Buffer NBO", TempXMLBuffer);
    end;
}