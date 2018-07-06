page 50102 "AI Translator Service Setup"
{
    PageType = Card;
    SourceTable = "AI Translator Service Setup";
    Caption = 'AI Translator Service Setup';
    UsageCategory = Administration;
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
                Caption = 'AI Supported Language';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Language;
                RunObject = page "AI Supported Languages List";

                trigger OnAction()
                begin

                end;
            }
        }
    }
}