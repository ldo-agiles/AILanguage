pageextension 50101 "AI Language on Sales Order" extends "Sales Order" //MyTargetPageId
{
    layout
    {
        //field not visible when added after "Quote No.". 
        //What am i missing here?
        //addafter("Quote No.")
        addfirst(General)
        {
            field("AI Language"; "AI Language")
            {
                ApplicationArea = ALL;
                Visible = true;
                CaptionML = ENU = 'AI Language',
                            DEU = 'KI Sprache';
            
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action(Translate)
            {
                ApplicationArea = ALL;
                Caption = 'Translate';
                ToolTip = 'Translate';
                Promoted = true;
                PromotedIsBig = true;
                Image = Language;

                trigger OnAction()
                begin
                    MESSAGE('Übersetzte!');
                end;
            }
        }
    }
}