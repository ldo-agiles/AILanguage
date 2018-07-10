page 50103 "AI Translator Setup Wizard"
{
    Caption='AI Translator Setup Wizard';
    PageType = NavigatePage;
    SourceTable = "AI Translator Service Setup";
    SourceTableTemporary=true;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Caption='';
                Editable=false;
                Visible=TopBannerVisible AND NOT FinishActionEnabled;
                field(MediaResourcesStandard;MediaResourcesStandard."Media Reference")
                {
                  ApplicationArea = All;
                  Editable=false;
                  ShowCaption=false;
                }
            }
            
            group(FinishedBanner)
            {
                Caption='';
                Editable=false;
                Visible=TopBannerVisible AND FinishActionEnabled;
                field(MediaResourcesDone;MediaResourcesDone."Media Reference")
                {
                  ApplicationArea = All;
                  Editable=false;
                  ShowCaption=false;
                }
            }

            group(Step1)
            {
                Visible=Step1Visible;
                group("Welcome to AI Translator Service")
                {
                    Caption='AI Translator Service Setup';
                    Visible=Step1Visible;
                    group(Group18)
                    {
                        Caption='';
                        InstructionalText='Hello - This Wizard will guide you through the installation.';
                    }
                }
                group("Let's go!")
                {
                    Caption='Let''s go!';
                    group(Group22)
                    {
                        Caption='';
                        InstructionalText='Prequisites: Please keep your Azure Key at hand.';
                    }
                }
            }

            group(Step2)
            {
                Caption='';
                InstructionalText='Please insert your Azure Key.';
                Visible=Step2Visible;
                
                field("Azure Key";"Azure Key")
                {
                    ApplicationArea = All;
                }
            }
            

            group(Step3)
            {
                Visible=Step3Visible;
                group(Group23)
                {
                    Caption='';
                    InstructionalText='Saving the setupdata.';
                }
                group("That's it!")
                {
                    Caption='That''s it!';
                    group(Group25)
                    {
                        Caption='';
                        InstructionalText='To save this setup, choose Finish.';
                    }
                }
            }
        }
    }
actions
{
    area(processing)
    {
        action(ActionBack)
        {
            ApplicationArea = All;
            Caption='Back';
            Enabled=BackActionEnabled;
            Image=PreviousRecord;
            InFooterBar=true;
            trigger OnAction();
            begin
                NextStep(TRUE);
            end;
        }
        action(ActionNext)
        {
            ApplicationArea = All;
            Caption='Next';
            Enabled=NextActionEnabled;
            Image=NextRecord;
            InFooterBar=true;
            trigger OnAction();
            begin
                NextStep(FALSE);
            end;
        }      
        action(ActionFinish)
        {
            ApplicationArea = All;
            Caption='Finish';
            Enabled=FinishActionEnabled;
            Image=Approve;
            InFooterBar=true;
            trigger OnAction();
            begin
                FinishAction;
            end;
        }
    }
}
trigger OnInit();
begin
  LoadTopBanners;
end;
trigger OnOpenPage();
var
    RecordVar : Record "AI Translator Service Setup";
begin
    INIT;
    IF RecordVar.GET THEN BEGIN
      TRANSFERFIELDS(RecordVar);
    END;
    INSERT;

    Step := Step::Start;
    EnableControls;
end;
var
    MediaRepositoryStandard : Record "Media Repository";
    MediaRepositoryDone : Record "Media Repository";
    MediaResourcesStandard : Record "Media Resources";
    MediaResourcesDone : Record "Media Resources";
    Step : Option Start,Step2,Finish;
    TopBannerVisible : Boolean;
    Step1Visible : Boolean;
    Step2Visible : Boolean;
    Step3Visible : Boolean;
    FinishActionEnabled : Boolean;
    BackActionEnabled : Boolean;
    NextActionEnabled : Boolean;
local procedure EnableControls();
begin
  ResetControls;

  CASE Step OF
    Step::Start:
      ShowStep1;
    Step::Step2:
      ShowStep2;
    Step::Finish:
      ShowStep3;
  END;
end;

local procedure StoreRecordVar();
var
    RecordVar : Record "AI Translator Service Setup";
begin
    IF NOT RecordVar.GET THEN BEGIN
        RecordVar.INIT;
        RecordVar.INSERT;
    END;

    RecordVar.TRANSFERFIELDS(Rec,FALSE);
    RecordVar.MODIFY(TRUE);
    COMMIT;
end;


local procedure FinishAction();
begin
  StoreRecordVar;
  CurrPage.CLOSE;
end;

local procedure NextStep(Backwards : Boolean);
begin
  IF Backwards THEN
    Step := Step - 1
  ELSE
    Step := Step + 1;

  EnableControls;
end;

local procedure ShowStep1();
begin
  Step1Visible := TRUE;

  FinishActionEnabled := FALSE;
  BackActionEnabled := FALSE;
end;

local procedure ShowStep2();
begin
  Step2Visible := TRUE;
end;

local procedure ShowStep3();
begin
  Step3Visible := TRUE;

  NextActionEnabled := FALSE;
  FinishActionEnabled := TRUE;
end;

local procedure ResetControls();
begin
  FinishActionEnabled := FALSE;
  BackActionEnabled := TRUE;
  NextActionEnabled := TRUE;

  Step1Visible := FALSE;
  Step2Visible := FALSE;
  Step3Visible := FALSE;
end;

local procedure LoadTopBanners();
begin
  IF MediaRepositoryStandard.GET('AssistedSetup-NoText-400px.png',FORMAT(CURRENTCLIENTTYPE)) AND
     MediaRepositoryDone.GET('AssistedSetupDone-NoText-400px.png',FORMAT(CURRENTCLIENTTYPE))
  THEN
    IF MediaResourcesStandard.GET(MediaRepositoryStandard."Media Resources Ref") AND
       MediaResourcesDone.GET(MediaRepositoryDone."Media Resources Ref")
    THEN
      TopBannerVisible := MediaResourcesDone."Media Reference".HASVALUE;
end;
}