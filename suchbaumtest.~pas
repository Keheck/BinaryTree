unit suchbaumtest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ColorGrd, StdCtrls, Menus, ExtCtrls, ComCtrls, ToolWin, ImgList, Spin,
  uTSuchbaum, Buttons;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    N1: TMenuItem;
    Druckereinrichtung1: TMenuItem;
    Drucken1: TMenuItem;
    N2: TMenuItem;
    Speichernunter1: TMenuItem;
    ffnen1: TMenuItem;
    Textdateiladen1: TMenuItem;
    InTextdateiexportieren1: TMenuItem;
    N3: TMenuItem;
    Suchbaum1: TMenuItem;
    Anzeigen1: TMenuItem;
    NeuSuchbaumlschen1: TMenuItem;
    N4: TMenuItem;
    Knotenanzahl1: TMenuItem;
    Minimum1: TMenuItem;
    Maximum1: TMenuItem;
    Hhe1: TMenuItem;
    N5: TMenuItem;
    Ausgleichen1: TMenuItem;
    optimalfllen1: TMenuItem;
    N6: TMenuItem;
    Traversieren1: TMenuItem;
    ToolbarImages: TImageList;
    StandardToolBar: TToolBar;
    B_optimalladen: TToolButton;
    B_sortiertspeichern: TToolButton;
    B_Textladen: TToolButton;
    B_Textspeichern: TToolButton;
    ToolButton5: TToolButton;
    B_Drucken: TToolButton;
    B_Anzahl: TToolButton;
    B_Hoehe: TToolButton;
    ToolButton2: TToolButton;
    B_Einsortieren: TToolButton;
    Edit1: TEdit;
    ToolButton16: TToolButton;
    Label1: TLabel;
    Label2: TLabel;
    PaintBox: TPaintBox;
    fontsize: TSpinEdit;
    ToolButton3: TToolButton;
    B_Entfernen: TToolButton;
    B_suchen: TToolButton;
    B_min: TToolButton;
    B_max: TToolButton;
    B_Ausgleich: TToolButton;
    B_optimal: TToolButton;
    B_traversieren: TToolButton;
    ToolButton7: TToolButton;
    N7: TMenuItem;
    BaumausDateiladen1: TMenuItem;
    Baumspeichern1: TMenuItem;
    B_laden: TToolButton;
    B_Speichern: TToolButton;
    B_neu: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Anzeigenclick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure B_EinsortierenClick(Sender: TObject);
    procedure fontsizeChange(Sender: TObject);
    procedure optimalfllen1Click(Sender: TObject);
    procedure Minimum1Click(Sender: TObject);
    procedure Maximum1Click(Sender: TObject);
    procedure Knotenanzahl1Click(Sender: TObject);
    procedure Traversieren1Click(Sender: TObject);
    procedure Hhe1Click(Sender: TObject);
    procedure Ausgleichen1Click(Sender: TObject);
    procedure B_EntfernenClick(Sender: TObject);
    procedure ffnen1Click(Sender: TObject);
    procedure Speichernunter1Click(Sender: TObject);
    procedure Textdateiladen1Click(Sender: TObject);
    procedure BaumausDateiladen1Click(Sender: TObject);
    procedure Baumspeichern1Click(Sender: TObject);
    procedure NeuSuchbaumlschen1Click(Sender: TObject);
    procedure B_suchenClick(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure InTextdateiexportieren1Click(Sender: TObject);
  private
    Baum: TSuchbaum;
    procedure PaintBoxPaint(Sender: TObject);
  public
    procedure Test(s: Elementtyp);
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
   Baum:=TSuchbaum.create;
   PaintBox.onPaint:=PaintBoxPaint;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Baum.free;
  Baum:=nil;
end;

procedure TForm1.Test(s: Elementtyp);
begin
  showmessage(s);
end;

procedure TForm1.Anzeigenclick(Sender: TObject);
begin
  Baum.Ausgabe(paintbox.width, PaintBox.canvas);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then B_EinsortierenClick(Sender);
end;

procedure TForm1.PaintBoxPaint(Sender: TObject);
begin
  Baum.Ausgabe(paintbox.width, paintbox.canvas);
end;

procedure TForm1.B_EinsortierenClick(Sender: TObject);
begin
  if edit1.text <> '' then begin
    Baum.einsortieren(edit1.text);
    edit1.text:='';
    Anzeigenclick(nil);
    edit1.SetFocus;
  end;
end;

procedure TForm1.fontsizeChange(Sender: TObject);
begin
  paintbox.Font.Size:=fontsize.value;
  Anzeigenclick(nil);
end;

procedure TForm1.optimalfllen1Click(Sender: TObject);
begin
  Baum.optimieren;
  Anzeigenclick(nil);
end;

procedure TForm1.Minimum1Click(Sender: TObject);
begin
  showmessage('Kleinster Eintrag im Baum: '+#13+Baum.min);
end;

procedure TForm1.Maximum1Click(Sender: TObject);
begin
  showmessage('Größter Eintrag im Baum: '+#13+Baum.max);
end;

procedure TForm1.Knotenanzahl1Click(Sender: TObject);
begin
  showmessage('Knotenanzahl: '+inttostr(Baum.Knotenanzahl));
end;

procedure TForm1.Traversieren1Click(Sender: TObject);
begin
  Baum.onBesuch:=Test;
  Baum.traversiere;
end;

procedure TForm1.Hhe1Click(Sender: TObject);
begin
  showmessage('Baumhöhe: '+inttostr(Baum.Hoehe));
end;

procedure TForm1.Ausgleichen1Click(Sender: TObject);
begin
  Baum.ausgleichen;
  Anzeigenclick(nil);
end;

procedure TForm1.B_EntfernenClick(Sender: TObject);
begin
  Baum.loesche(edit1.text);
  Anzeigenclick(nil);
end;

procedure TForm1.Textdateiladen1Click(Sender: TObject);
//Es wird eine Textdatei geladen, indem jede Zeile der Datei als Suchbegriff in
//Baum eingefügt wird.
begin
  OpenDialog.Filter:='Textdateien (*.txt)|*.TXT|alle Dateien (*.*)|*.*';
  OpenDialog.Title:='Textdatei importieren';
  if OpenDialog.Execute then begin
    Baum.Textladen(OpenDialog.FileName);
    Anzeigenclick(nil);
  end;
end;

procedure TForm1.InTextdateiexportieren1Click(Sender: TObject);
begin
  SaveDialog.DefaultExt:='txt';
  SaveDialog.Filter:='Textdateien (*.txt)|*.TXT|alle Dateien (*.*)|*.*';
  SaveDialog.Title:='Baum in eine Textdatei exportieren';
  if SaveDialog.Execute then Baum.Textspeichern(SaveDialog.FileName);
end;

procedure TForm1.BaumausDateiladen1Click(Sender: TObject);
begin
  OpenDialog.Filter:='Suchbaumdatei (*.SBD)|*.SBD|alle Dateien (*.*)|*.*';
  OpenDialog.Title:='Suchbaumdatei laden';
  if OpenDialog.Execute then begin
    Baum.laden(OpenDialog.FileName);
    Anzeigenclick(nil);
  end;
end;

procedure TForm1.Baumspeichern1Click(Sender: TObject);
begin
  SaveDialog.DefaultExt:='SBD';
  SaveDialog.Filter:='Suchbaumdatei (*.SBD)|*.SBD|alle Dateien (*.*)|*.*';
  SaveDialog.Title:='Suchbaum in einer Datei speichern';
  if SaveDialog.Execute then Baum.speichern(SaveDialog.FileName);
end;

procedure TForm1.ffnen1Click(Sender: TObject);
begin
  OpenDialog.Filter:='Suchbaumdatei (*.SBD)|*.SBD|alle Dateien (*.*)|*.*';
  OpenDialog.Title:='Suchbaumdatei laden';
  if OpenDialog.Execute then begin
    Baum.optimalladen(OpenDialog.FileName);
    Anzeigenclick(nil);
  end;
end;

procedure TForm1.Speichernunter1Click(Sender: TObject);
begin
  SaveDialog.DefaultExt:='SBD';
  SaveDialog.Filter:='Suchbaumdatei (*.SBD)|*.SBD|alle Dateien (*.*)|*.*';
  SaveDialog.Title:='Suchbaum sortiert in einer Datei speichern';
  if SaveDialog.Execute then Baum.sortiertspeichern(SaveDialog.FileName);
end;

procedure TForm1.NeuSuchbaumlschen1Click(Sender: TObject);
begin
  Baum.Baumloeschen;
  Anzeigenclick(nil);
end;

procedure TForm1.B_suchenClick(Sender: TObject);
begin
  if Baum.suche(Edit1.text) then showmessage('Eintrag vorhanden.')
  else showmessage('Eintrag nicht vorhanden.')
end;

procedure TForm1.Beenden1Click(Sender: TObject);
begin
  close;
end;

end.
