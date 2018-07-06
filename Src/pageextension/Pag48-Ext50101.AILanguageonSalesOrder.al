pageextension 50101 "AI Language on Sales Order" extends "Sales Order" //48
{
    layout
    {
        //field not visible when added after "Quote No.". 
        //What am i missing here?
        //addafter("Quote No.")
        addafter("Quote No.")
        {
            field("AI Language"; "AI Language")
            {
                ApplicationArea = ALL;
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