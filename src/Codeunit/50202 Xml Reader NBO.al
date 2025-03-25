codeunit 50202 "XML Reader NBO"
{
    procedure ReadXml(XmlDataP: Text)
    var
        XmlDocL: XmlDocument;
        RootL: XmlElement;
        XmlNodeL: XmlNode;
        NodeList1L: XmlNodeList;
        NodeList2L: XmlNodeList;
        NodeList3L: XmlNodeList;
        NodeList4L: XmlNodeList;
        NodeList5L: XmlNodeList;
        NodeList6L: XmlNodeList;
        Element1L: XmlElement;
        Element2L: XmlElement;
        Element3L: XmlElement;
        Element4L: XmlElement;
        Element5L: XmlElement;
        Element6L: XmlElement;
        XmlAttrColL: XmlAttributeCollection;
        XmlAttrL: XmlAttribute;
        ValueL: Text;

        // Attributes
        CurrencyCodeAlfaCharL: Code[10];
        CurrencyCodeNumCharL: Code[10];
        CurrencyNameEngL: Text;
        DateL: Date;
        BuyingRateL: Decimal;
        MiddleRateL: Decimal;
        SellingRateL: Decimal;
        FixingRateL: Decimal;
        UnitL: Integer;
        CounterL: Integer;
    begin

        // ClearLastExchangeRate();

        // Decode the XML document
        XmlDataP := XmlDataP.Replace('&lt;', '   <');
        XmlDataP := XmlDataP.Replace('&gt;', '>   ');
        // Message('XmlDataP.Formated: ' + Format(XmlDataP));

        // Try reading documnet
        XmlDocument.ReadFrom(XmlDataP, XmlDocL);

        // Load the XML data into the XmlDocument
        if not XmlDocument.ReadFrom(XmlDataP, XmlDocL) then
            Error('Failed to load XML data.');

        // Get the root element
        if not XmlDocL.GetRoot(RootL) then
            Error('Cannot get root element.');

        // Process child elements of the root element
        NodeList1L := RootL.GetChildElements();
        foreach XmlNodeL in NodeList1L do begin
            Element1L := XmlNodeL.AsXmlElement();

            // Process "GetCurrentExchangeRateResponse" elements
            NodeList2L := Element1L.GetChildElements('GetCurrentExchangeRateResponse', 'http://communicationoffice.nbs.rs');
            foreach XmlNodeL in NodeList2L do begin
                Element2L := XmlNodeL.AsXmlElement();

                // Process "GetCurrentExchangeRateResult" elements
                NodeList3L := Element2L.GetChildElements('GetCurrentExchangeRateResult', 'http://communicationoffice.nbs.rs');
                foreach XmlNodeL in NodeList3L do begin
                    Element3L := XmlNodeL.AsXmlElement();

                    // Process child elements of "ExchangeRateDataSet"
                    NodeList4L := Element3L.GetChildElements();
                    foreach XmlNodeL in NodeList4L do begin
                        Element4L := XmlNodeL.AsXmlElement();

                        CounterL := 1;
                        // Process child elements of "ExchangeRate"
                        NodeList5L := Element4L.GetChildElements();
                        foreach XmlNodeL in NodeList5L do begin
                            Element5L := XmlNodeL.AsXmlElement();

                            // // Process child elements of "ExchangeRate"
                            NodeList6L := Element5L.GetChildElements();
                            foreach XmlNodeL in NodeList6L do begin
                                Element6L := XmlNodeL.AsXmlElement();

                                // Initialize variables
                                CurrencyCodeNumCharL := '';
                                CurrencyNameEngL := '';
                                BuyingRateL := 0;
                                MiddleRateL := 0;
                                SellingRateL := 0;
                                UnitL := 0;

                                // Access each attribute by localName
                                IF Format(Element6L.LocalName) = 'Date' then begin
                                    Evaluate(DateL, Element6L.InnerText());
                                    CurrencyExchangeRateG.Add('Date', Format(DateL));
                                end;

                                IF Format(Element6L.LocalName) = 'CurrencyCodeNumChar' then begin
                                    Evaluate(CurrencyCodeNumCharL, ConvertStr(XmlNodeL.AsXmlElement().InnerText, '.', ','));
                                    CurrencyExchangeRateG.Add('CurrencyCodeNumChar', Format(CurrencyCodeNumCharL));
                                end;

                                IF Format(Element6L.LocalName) = 'CurrencyCodeAlfaChar' then begin
                                    CurrencyCodeAlfaCharL := Format(Element6L.InnerText());
                                    CurrencyExchangeRateG.Add('CurrencyCodeAlfaChar', Format(CurrencyCodeAlfaCharL));
                                end;

                                IF Format(Element6L.LocalName) = 'CurrencyNameEng' then begin
                                    CurrencyNameEngL := Format(Element6L.InnerText());
                                    CurrencyExchangeRateG.Add('CurrencyNameEng', Format(CurrencyNameEngL));
                                end;

                                IF Format(Element6L.LocalName) = 'BuyingRate' then begin
                                    Evaluate(BuyingRateL, ConvertStr(XmlNodeL.AsXmlElement().InnerText, '.', ','));
                                    CurrencyExchangeRateG.Add('BuyingRate', Format(BuyingRateL));
                                end;

                                IF Format(Element6L.LocalName) = 'MiddleRate' then begin
                                    Evaluate(MiddleRateL, ConvertStr(XmlNodeL.AsXmlElement().InnerText, '.', ','));
                                    CurrencyExchangeRateG.Add('MiddleRate', Format(MiddleRateL));
                                end;

                                IF Format(Element6L.LocalName) = 'SellingRate' then begin
                                    Evaluate(SellingRateL, ConvertStr(XmlNodeL.AsXmlElement().InnerText, '.', ','));
                                    CurrencyExchangeRateG.Add('SellingRate', Format(SellingRateL));
                                end;

                                IF Format(Element6L.LocalName) = 'Unit' then begin
                                    Evaluate(UnitL, ConvertStr(XmlNodeL.AsXmlElement().InnerText, '.', ','));
                                    CurrencyExchangeRateG.Add('Unit', Format(UnitL));
                                end;
                            end;

                            CurrencyG.Add('ExchangeRate' + Format(CounterL), CurrencyExchangeRateG);
                            Clear(CurrencyExchangeRateG);
                            CounterL += 1;
                        end;
                    end;
                end;
            end;
        end;

        CounterL := 1;
        // Preview
        foreach CurrencyExchangeRateG in CurrencyG.Values do begin
            IF CurrencyExchangeRateG.Get(Format('Date'), ValueG) then
                Evaluate(DateL, ValueG);
            IF CurrencyExchangeRateG.Get(Format('CurrencyCodeNumChar'), ValueG) then
                Evaluate(CurrencyCodeNumCharL, ValueG);
            IF CurrencyExchangeRateG.Get(Format('CurrencyCodeAlfaChar'), ValueG) then
                Evaluate(CurrencyCodeAlfaCharL, ValueG);
            IF CurrencyExchangeRateG.Get(Format('CurrencyNameEng'), ValueG) then
                Evaluate(CurrencyNameEngL, ValueG);
            IF CurrencyExchangeRateG.Get(Format('MiddleRate'), ValueG) then
                Evaluate(MiddleRateL, ValueG);
            IF CurrencyExchangeRateG.Get(Format('Unit'), ValueG) then
                Evaluate(UnitL, ValueG);

            // Update Currency
            UpdateCurrency(CurrencyCodeAlfaCharL, DateL, CurrencyCodeAlfaCharL, CurrencyCodeNumCharL, CurrencyNameEngL);
            UpdateExchangeRate(CurrencyCodeAlfaCharL, DateL, UnitL, UnitL, MiddleRateL, MiddleRateL);
            CounterL += 1;
        end;

        // Clear values from CurrencyG dictionary to prevent that the data already added to the list
        ClearAll();

        ////

    end;

    // Clear LastCurrencyExchangeRate records
    local procedure ClearLastExchangeRate()
    var
        DateL: Date;
        CurrencyExchangeRateClearG: Record "Currency Exchange Rate";
    begin
        DateL := Today();
        CurrencyExchangeRateClearG.SetFilter("Starting Date", Format(DateL));
        IF CurrencyExchangeRateClearG.FindSet() then begin
            repeat
                CurrencyExchangeRateClearG.Delete();
            until CurrencyExchangeRateClearG.Next() = 0;
        end;
    end;

    local procedure UpdateCurrency(var CurrencyCodeP: Code[10]; LastDateModifiedP: Date; ISOCodeP: Code[10]; ISONumericCodeP: Text; DescriptionP: Text)
    var
        CurrencyL: Record "Currency";

    begin
        IF CurrencyCodeP = '' then begin
            Error('UpdateCurrency.Missing currency code value.');
        end;

        CurrencyL.SetRange("Code", CurrencyCodeP);
        IF CurrencyL.FindSet() then begin
            CurrencyL."Last Date Modified" := LastDateModifiedP;
            CurrencyL."ISO Code" := ISOCodeP;
            CurrencyL."ISO Numeric Code" := ISONumericCodeP;
            CurrencyL."Description" := DescriptionP;
            CurrencyL.Modify;
            // Commit();
        end;
    end;

    local procedure UpdateExchangeRate(var CurrencyCodeP: Code[10]; StartingDateP: Date; ExchangeRateAmountP: Integer; AdjustmentExchRateAmountP: Integer; RelationalExchRateAmountP: Decimal; RelationalAdjmtExchRateAmtP: Decimal)
    var
        CurrencyExchangeRateL: Record "Currency Exchange Rate";
        DateL: Date;

    begin
        DateL := Today();

        IF CurrencyCodeP = '' then begin
            Error('UpdateExchangeRate.Missing currency code value.');
        end;

        // Check if UpdateExchangeRate already exist with the same date 
        CurrencyExchangeRateL.SetRange("Currency Code", CurrencyCodeP);
        CurrencyExchangeRateL.SetFilter("Starting Date", Format(DateL));
        IF CurrencyExchangeRateL.FindSet() then begin
            // Preform update of an existing records
            repeat
                CurrencyExchangeRateL.Delete();
            until CurrencyExchangeRateL.Next() = 0;

        end;

        // Preform the inserting of last exchange rate
        CurrencyExchangeRateL.Init();
        CurrencyExchangeRateL."Currency Code" := CurrencyCodeP;
        CurrencyExchangeRateL."Starting Date" := StartingDateP;
        CurrencyExchangeRateL."Exchange Rate Amount" := ExchangeRateAmountP;
        CurrencyExchangeRateL."Adjustment Exch. Rate Amount" := AdjustmentExchRateAmountP;
        CurrencyExchangeRateL."Relational Exch. Rate Amount" := RelationalExchRateAmountP;
        CurrencyExchangeRateL."Relational Adjmt Exch Rate Amt" := RelationalAdjmtExchRateAmtP;

        CurrencyExchangeRateL.Insert(true);
        // Commit();

    end;

    var
        ValueG: Text;
        CurrencyG: Dictionary of [Text, Dictionary of [Text, Text]];
        CurrencyExchangeRateG: Dictionary of [Text, Text];

}