table 50200 "NBS Setup NBO"
{
    fields
    {
        field(50200; "Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Id';
            ToolTip = '';
        }

        field(50201; "UserName"; Text[100])
        {

            DataClassification = ToBeClassified;
            Caption = 'Username';
            ToolTip = 'The Username';
        }


        field(50202; "Password"; Text[100])
        {

            DataClassification = ToBeClassified;
            Caption = 'Password';
            ToolTip = 'The Password';
        }


        field(50203; "LicenceId"; Text[100])
        {

            DataClassification = ToBeClassified;
            Caption = 'Licence Id';
            ToolTip = 'The Licence Id';
        }
    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
    }

    procedure InsertIfExist()
    begin
        Reset();
        If Not Get() then begin
            Init();
            Insert(true);
        end;
    end;

}