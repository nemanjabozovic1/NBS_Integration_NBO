page 50200 "NBS Setup NBO"
{
    //props
    ApplicationArea = All;
    Caption = 'NBS Setup';
    PageType = Card;
    SourceTable = "NBS Setup NBO";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(UserName; Rec.UserName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UserName field.';
                }

                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password field.';
                }

                field(LicenceId; Rec.LicenceId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Licence Id field.';
                }
            }
        }
    }
}