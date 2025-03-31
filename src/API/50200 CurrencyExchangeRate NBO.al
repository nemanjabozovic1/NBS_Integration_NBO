/// <summary>
/// Page Currency Exchange Rate NBO (ID 50202).
/// </summary>
page 50202 "Currency Exchange Rate NBO"
{
    APIGroup = 'NBS';
    APIPublisher = 'NBO';
    APIVersion = 'v2.0';
    ChangeTrackingAllowed = true;
    EntityName = 'CurrencyExchangeRate';
    EntitySetName = 'CurrencyExchangeRates';
    ODataKeyFields = "SystemId";
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Currency Exchange Rate";
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field("CurrencyCode"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the foreign currency on this line.';
                    ShowMandatory = true;
                }
                field("StartingDate"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on which the exchange rate on this line comes into effect.';
                }
                field("RelationalCurrencyCode"; Rec."Relational Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how you want to set up the two currencies, one of the currencies can be LCY, for which you want to register exchange rates.';
                }
                field("ExchangeRateAmount"; Rec."Exchange Rate Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amounts that are used to calculate exchange rates for the foreign currency on this line.';
                }
                field("RelationalExchRateAmount"; Rec."Relational Exch. Rate Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amounts that are used to calculate exchange rates for the foreign currency on this line.';
                }
                field("AdjustmentExchRateAmount"; Rec."Adjustment Exch. Rate Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amounts that are used to calculate exchange rates that will be used by the Adjust Exchange Rates batch job.';
                }
                field("RelationalAdjmtExchRateAmt"; Rec."Relational Adjmt Exch Rate Amt")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amounts that are used to calculate exchange rates that will be used by the Adjust Exchange Rates batch job.';
                }
                field("FixExchangeRateAmount"; Rec."Fix Exchange Rate Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the currency''s exchange rate can be changed on invoices and journal lines.';
                }
            }
        }
    }
}