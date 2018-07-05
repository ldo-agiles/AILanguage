page 50102 "AI Translator Service Setup"
{
    PageType = Card;
    SourceTable = "AI Translator Service Setup";
    CaptionML = ENU = 'AI Translator Service Setup',
                DEU = 'KI Übersetzungsservice Einrichtung';
    UsageCategory=Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(Setup)
            {
                field(URL; URL)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action("Supported languages list")
            {
                ApplicationArea = All;
                Caption ='AI Supported Language';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Language;


                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}