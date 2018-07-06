page 50101 "AI Supported Languages List"
{
    PageType = List;
    SourceTable = "AI Supported Language";
    Caption = 'AI Supported Languages List'; //CaptionML will be depreciated
    UsageCategory=Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                }
                field(Description;Description)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            
        }
    }
    
    actions
    {
        area(processing)
        {

        }
    }
}