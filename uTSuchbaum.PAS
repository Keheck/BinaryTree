UNIT uTSuchbaum;
//°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
// ADT "binärer Suchbaum" in LWR-Sortierung
//°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
// Version       : 1.0 Übungsbeispiel
// Autor         : Vorgabe des Klassenentwurfs A. Potröck, IKG Berlin-Lichtenberg
//               :
// Aufgabe       : Unterrichtsbeispiel zu dynamischen Datenstrukturen mit
//                 praktischem Hintergrund.
//                 Implementation zwecks Übung unvollständig
// Compiler      : Delphi 5.0
//               : 22.09.2000 ...
//               : 06.07.2013 .
//°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
INTERFACE

uses
  graphics, Dialogs, sysutils, math;

TYPE
  Elementtyp = string[40];
  Feld = array of Elementtyp;

  TKnoten = class
    Daten: Elementtyp;
    L, R: TKnoten
  end;

  TSuchbaum = class
    protected
      Wurzel: TKnoten;
    public
    onBesuch: procedure (inh: Elementtyp) of object;
    constructor create;
    //Der Baum wird initialisiert. Muss vor Verwenden des Baumes aufgerufen werden.
    function leer: boolean;
    //Liefert "True", wenn der Baum keine Daten enthält.
    procedure einsortieren(E: Elementtyp);
    //Das Datenelement "E" wird in den Baum unter der Beachtung der Sortierung
    //eingefügt. Leere Strings und schon im Baum vorhandene werden nicht aufgenommen.
    function suche(E: Elementtyp): boolean;
    //Ist "E" im Baum wird "True" geliefert, sonst "False". Praktischer
    //ist zwar das Zurückgeben eines Pointers auf das Datenelement, aber diese
    //Klasse ist ja ein Demonstrations- bzw. Übungsbeispiel.
    //function suche (E: Elementtyp): TKnoten;
    function MAX: Elementtyp;
    //Liefert das Maximum des Baumes "Wurzel". Beim leeren Baum ''.
    function MIN: Elementtyp;
    //Liefert das Minimum des Baumes "Wurzel". Beim leeren Baum ''.
    function Knotenanzahl: INTEGER;
    //Liefert die Anzahl der Knoten des Baumes "Wurzel".
    procedure traversiere;
    //Der Baum wird nach der LWR-Sortierung durchlaufen, also jeder Knoten einmal
    //besucht. Vom kleinsten Eintrag zum größten wird dabei nacheinander die Methode
    //ausgeführt, die auf "onBesuch" zugewiesen wurde.
    procedure Baumloeschen;
    //Löscht alle Knoten des Baumes. Baum ist dann leer.
    function loesche(E: Elementtyp): boolean;
    //Der Knoten mit den Daten "E" wird aus dem Baum gelöscht. Gelingt das,
    //weil der Eintrag existiert, wird "True" zurückgegeben, sonst "False"
    function Hoehe: INTEGER;
    //Die Höhe des Baumes wird geliefert. Der leere Baum hat die Höhe Null.
    procedure ausgleichen;
    //Der Baum wird ausgeglichen, d.h. es gibt in keinem Teilbaum einen größeren
    //Höhenunterschied als 1. Es führt nicht zwangsläufig zu einem optimal gefüllten
    //Baum, was für die Suchlaufzeit aber kaum von Bedeutung ist (AVL-Baum).
    procedure optimieren;
    //Der Baum wird ausgeglichen und soweit es geht komplett gefüllt.
    procedure Textladen(Dateiname: String);
    //Eine Textdatei wird in den Baum einsortiert, indem jede Zeile ein Eintrag
    //wird.
    procedure Textspeichern(Dateiname: String);
    //Eine Textdatei wird erzeugt und die Einträge zeilenweise gespeichert.
    //Mit "Textladen" soll der Baum wieder genauso entstehen.
    function speichern(Dateiname: String): INTEGER;
    //Es wird eine typisierte Datei mit "Dateinname" (evtl. mit Pfadangabe)
    //des Elementtyps erzeugt, in die die Einträge des Baumes von der Wurzel
    //aus geschrieben werden, so dass mit "laden" der Baum genauso wieder erzeugt
    //werden kann. Es wird ein Fehlercode geliefert, der den üblichen Ein-
    //Ausgabefehlercodes entspricht, also bei Null ist alles i.O.
    procedure laden(Dateiname : String);
    //Es wird eine Datei mit "Dateiname", die mit "speichern" erzeugt wurde,
    //in den Baum eingelesen. Der Baum wird vorher gelöscht. Man erhält den
    //Baum, der vorher gespeichert war.
    function sortiertspeichern(Dateiname: String): INTEGER;
    //Es wird eine typisierte Datei mit "Dateinname" (evtl. mit Pfadangabe)
    //des Elementtyps erzeugt, in die die Einträge des Baumes in sortierter
    //Reihenfolge geschrieben werden. Es wird ein Fehlercode geliefert, der den
    //üblichen Ein- Ausgabefehlercodes entspricht, also bei Null ist alles i.O.
    procedure optimalladen(Dateiname : String);
    //Es wird eine Datei mit "Dateiname", die mit "sortiertspeichern" erzeugt wurde, in den Baum
    //eingelesen. Der Baum wird vorher gelöscht. Man erhält einen vollständig
    //gefüllten und damit ausgeglichenen Baum.
    procedure Ausgabe (Breite: integer; c: TCanvas);
    //Zeichnet den Baum "SB" auf die Zeichenfläche "c", in der Breite, die mit
    //"Breite" angegeben wird.
    destructor destroy; override;
    //Objekt wird mit all seinen Knoten aus den Speicher entfernt.
  private
    index: integer;
  end;

IMPLEMENTATION

constructor TSuchbaum.create;
begin
  inherited create;
  Wurzel:=nil;
end;

function TSuchbaum.leer;
begin
  result:=Wurzel = nil;
end;

procedure TSuchbaum.einsortieren(E: Elementtyp);
//Erzeugt Knoten und sortiert ihn ein.

  procedure einfuegen(var w: TKnoten);
  begin
      if w = nil then
      begin
          w := TKnoten.create;
          w.daten := e;
      end
      else
      begin
          if e < w.daten then
              einfuegen(w.l)
          else if e > w.daten then
              einfuegen(w.r);
      end;
  end;

begin
  einfuegen(Wurzel);
end;

procedure TSuchbaum.Baumloeschen;

  procedure entfernen(w: TKnoten);
  begin
      if w <> nil then
      begin
          entfernen(w.l);
          entfernen(w.r);
          w.free;
      end;
  end;

begin
  entfernen(Wurzel);
  Wurzel := nil;
end;

function TSuchbaum.Knotenanzahl: INTEGER;

  function KAnzahl(W: TKnoten): INTEGER;
  begin
      result := 0;
      if w <> nil then
          result := KAnzahl(w.l) + 1 + KAnzahl(w.r);
  end;

begin
  result:=KAnzahl(Wurzel);
end;

function links(W: Tknoten): Elementtyp;
begin
  if W <> nil then
    if W.L <> nil then result:=links(W.L)
    else result:=W.daten
  else result:=''; //Der Baum ist leer !
end;

function TSuchbaum.MIN: Elementtyp;
begin
  result:=links(Wurzel);
end;

function TSuchbaum.MAX: Elementtyp;

  function rechts(w: Tknoten): Elementtyp;
  begin
      if W <> nil then
          if W.R <> nil then result:=rechts(W.R)
          else result:=W.daten
      else result:=''; //Der Baum ist leer !
  end;

begin
    result := rechts(wurzel);
end;

function TSuchbaum.suche(E: Elementtyp): boolean;
var w: TKnoten;
begin
    result := false;
    w := wurzel;

    while (not result) and (w <> nil) do
    begin
        result := w.daten = e;

        if e < w.daten then
            w := w.l
        else
            w := w.r;
    end;
end;

procedure TSuchbaum.traversiere;
procedure besuchen(w: TKnoten);
begin
    if w <> nil then
    begin
        besuchen(w.l);
        if assigned(onBesuch) then onBesuch(w.daten);
        besuchen(w.r);
    end;
end;
begin
    besuchen(wurzel);
end;

function Ebene(w: TKnoten): integer;
var left, right: integer;
begin
    if w = nil then
        result := 0
    else
    begin
        left := Ebene(w.l);
        right := Ebene(w.r);

        if left > right then
            result := left + 1
        else
            result := right + 1;
    end;
end;

function TSuchbaum.Hoehe: integer;
begin
    result := ebene(wurzel);
end;

function istBlatt(w: TKnoten): boolean;
begin
    result := (w.l = nil) and (w.r = nil);
end;

procedure TSuchbaum.ausgleichen;
procedure teilAusgleich(var W: TKnoten);
var h: TKnoten;
begin
    //Gehe bis zum "kleinsten" optimierbaren Teilbaum
    if(ebene(w.l) > 3) then
        teilausgleich(w.l);
    if(ebene(w.r) > 3) then
        teilausgleich(w.r);

    //showmessage(w.daten);

    h := w;

    //links...
    if ebene(w.l) > ebene(w.r) then
    begin
        //...links
        if (w.l.r = nil) or istBlatt(w.l.r) then
        begin
            w := h.l;
            h.l := w.r;
            w.r := h;
        end
        //...rechts
        else
        begin
            w := w.l.r;
            h.l.r := w.l;
            w.l := h.l;
            h.l := w.r;
            w.r := h;
        end;
    end
    //rechts...
    else
    begin
        //...rechts
        if (w.r.l = nil) or istBlatt(w.r.l) then
        begin
            w := h.r;
            h.r := w.l;
            w.l := h;
        end
        //...links
        else
        begin
            w := w.r.l;
            h.r.l := w.r;
            w.r := h.r;
            h.r := w.l;
            w.l := h;
        end;
    end;
end;
begin
    teilausgleich(wurzel);
end;

procedure TSuchbaum.optimieren;
var elems: Feld;
procedure fuellArray(w: TKnoten);
begin
    if w <> nil then
    begin
        fuellArray(w.l);
        elems[index] := w.daten;
        inc(index);
        fuellArray(w.r);
    end;
end;
procedure fuellBaum(min, max: integer);
var i: integer;
begin
    i := (min+max) div 2;
    if(min <= max) then
    begin
        einsortieren(elems[i]);
        fuellBaum(min, i-1);
        fuellBaum(i+1, max);
    end;
end;
begin
    index := 0;
    setlength(elems, knotenanzahl-1);
    fuellArray(wurzel);
    baumloeschen;
    fuellBaum(0, length(elems));
    setlength(elems, 0);
end;

function TSuchbaum.loesche(E: Elementtyp): boolean;
function entfernen(var w: TKnoten): boolean;
var r: Elementtyp;
begin
    if w.daten > e then
        result := entfernen(w.l)
    else if w.daten < e then
        result := entfernen(w.r)
    else
    begin
        result := w <> nil;

        if result then
        begin
            //Blatt
            if istBlatt(w) then
            begin
                w.free;
                w := nil;
            end
            //Nur ein Kind
            else if (w.l = nil) xor (w.r = nil) then
            begin
                if w.l = nil then
                    w := w.r
                else
                    w := w.l;
            end
            //Zwei Kinder
            else
            begin
                r := links(w.r);
                loesche(r);
                w.daten := r;
            end;
        end;
    end;
end;
begin
    result := entfernen(wurzel);
end;

function TSuchbaum.speichern(Dateiname: String): INTEGER;
//Speichert den Baum als Datei so ab, wie er ist.
begin
end;

procedure TSuchbaum.laden(Dateiname: String);
//Liest den Baum aus einer typisierten Datei ein.
begin
end;

function TSuchbaum.sortiertspeichern(Dateiname: String): INTEGER;
//Speichert den Baum als sortierte Datei ab.
begin
end;

procedure TSuchbaum.optimalladen(Dateiname: String);
//Liest den Baum aus einer sortierten Datei ideal ausgeglichen ein.
begin
end;

procedure TSuchbaum.Textladen(Dateiname: String);
//Liest den Baum aus einer Textdatei ein.
var datei: TextFile;
    s: String;
begin
    baumloeschen;
    assignFile(datei, dateiname);
    reset(datei);

    repeat
        readln(Datei, s);
        einsortieren(s);
    until EoF(datei);

    closeFile(datei);
end;

procedure TSuchbaum.Textspeichern(Dateiname: String);
//Speichert die Dateninhalte des Baumes in einer Textdatei. (WLR)
begin
end;

procedure ztext(c: TCanvas; x, y: integer; txt: string);
begin
  c.TextOut(x - c.textwidth(txt) div 2, y, txt);
end;

procedure linie(c: TCanvas; xa, ya, xe, ye: integer);
begin
  c.moveto(xa, ya); c.lineto(xe, ye);
end;

procedure anzeigen(SB: TKnoten; Breite, x, h: integer; c: TCanvas);
const
  Kantenhoehe = 50;
var
  Knotenabstand: integer;
begin
  if SB <> nil then begin
    Knotenabstand:=Breite shr (h + 1); //(Höhe + 1) mal durch 2 teilen ...
    ztext(c, x, Kantenhoehe*(h - 1), sb.daten);
    anzeigen(SB.L, Breite, x - Knotenabstand, h + 1, c);
    anzeigen(SB.R, Breite, x + Knotenabstand, h + 1, c);
    if SB.L <> nil then
      linie(c, x, Kantenhoehe*(h - 1) + c.textheight('gÄ'), x - Knotenabstand, Kantenhoehe*h);
    if SB.R <> nil then
      linie(c, x, Kantenhoehe*(h - 1) + c.textheight('gÄ'), x + Knotenabstand, Kantenhoehe*h);
  end;
end;

procedure TSuchbaum.Ausgabe(Breite: integer; c: TCanvas);
begin
  c.brush.style:=bssolid;
  c.rectangle(c.ClipRect);
  c.brush.style:=bsclear;
  if Wurzel = nil then
    c.TextOut(Breite div 2 - c.textwidth('Der Baum ist leer !') div 2, 3, 'Der Baum ist leer !')
  else
    anzeigen(wurzel, Breite, Breite div 2, 1 ,c);
end;

destructor TSuchbaum.destroy;
begin
  Baumloeschen;
  inherited destroy;
end;

end.

