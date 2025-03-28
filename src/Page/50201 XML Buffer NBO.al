page 50201 "XML Buffer NBO"
{
    //props
    PageType = List;
    ApplicationArea = All;
    SourceTable = "XML Buffer";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';

                }
                field(Path; Rec.Path)
                {
                    Caption = 'Path';

                }
                field(Value; Rec.Value)
                {
                    Caption = 'Value';

                }
                field(Depth; Rec.Depth)
                {
                    Caption = 'Depth';
                }
                field("Parent Entry No."; Rec."Parent Entry No.")
                {
                    Caption = 'Parent Entry No.';
                }
                field("Data Type"; Rec."Data Type")
                {
                    Caption = 'Data Type';
                }
                field("Node Number"; Rec."Node Number")
                {
                    Caption = 'Node Number';
                }
                field(Namespace; Rec.Namespace)
                {
                    Caption = 'Namespace';
                }
                field("Import ID"; Rec."Import ID")
                {
                    Caption = 'Import ID';
                }
                field("Value BLOB"; Rec."Value BLOB")
                {
                    Caption = 'Value BLOB';
                }
            }
        }
    }
}