page 50101 "AI Supported Languages List"
{
    PageType = List;
    SourceTable = "AI Supported Language";
    CaptionML = ENU = 'AI Supported Languages List',
                DEU = 'KI unterstütze Sprachen Liste';
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