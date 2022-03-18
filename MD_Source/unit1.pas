unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,unit3,windows;


type

  { TForm1 }

  TForm1 = class(TForm)
    Check_AA: TCheckBox;
    check_MouseView: TCheckBox;
    check_prop: TCheckBox;
    ColorDialog1: TColorDialog;
    scroll_interval: TScrollBar;
    Lab_InterVal: TStaticText;
    Shape1: TShape;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Check_AAChange(Sender: TObject);
    procedure check_MouseViewChange(Sender: TObject);
    procedure check_propChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Img1Click(Sender: TObject);
    procedure Lab_InterValClick(Sender: TObject);
    procedure Lab_MColorClick(Sender: TObject);
    procedure scroll_intervalChange(Sender: TObject);
    procedure Shape1ChangeBounds(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  first_timer:boolean;
implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.Img1Click(Sender: TObject);
begin

end;

procedure TForm1.Lab_InterValClick(Sender: TObject);
begin

end;

procedure TForm1.Lab_MColorClick(Sender: TObject);
begin
//if colorDialog1.Execute then lab_mColor.Color:=colorDialog1.Color;
end;

procedure TForm1.scroll_intervalChange(Sender: TObject);
begin
form2.timer1.Interval:=scroll_interval.Position;
  lab_interval.caption:='Задержка(ms)='+IntToStr(scroll_interval.Position);

end;

procedure TForm1.Shape1ChangeBounds(Sender: TObject);
begin
  //if colorDialog1.Execute then Shape1.Brush.Color:=colorDialog1.Color;
  form2.img1.picture.Bitmap.canvas.Pen.Color:=rgbToColor(0,0,0);
  form2.img1.picture.Bitmap.canvas.Brush.Color:=Shape1.Brush.Color;

end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if colorDialog1.Execute then Shape1.Brush.Color:=colorDialog1.Color;

   form2.img1.picture.Bitmap.canvas.Pen.Color:=rgbToColor(0,0,0);
   form2.img1.picture.Bitmap.canvas.Brush.Color:=Shape1.Brush.Color;


end;

procedure TForm1.Timer1Timer(Sender: TObject);
var mon_index1,mon_index2:integer;
    c:real;
    h1,w1:integer;
    mx,my,mSize:integer;
begin




mon_index1:=0;
mon_index2:=1;

//выход если окно свернуто
//if not( IsWindowVisible(Handle) or IsIconic(Handle) ) then exit;

if first_timer then begin
               first_timer:=false;
               form2.Visible:=true;
               timer1.Interval:=scroll_interval.Position;

               mx:=10;
               my:=10;
               mSize:=20;
               form2.Timer1.Enabled:=true;
               form2.Timer1.Interval:=scroll_interval.Position;
               form1.Timer1.Enabled:=false;
               exit;
               end;









end;

procedure TForm1.Button1Click(Sender: TObject);


begin


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
  Bmp: TBitmap;
 // p1,p2:prgbArray;
  //Jpg: TJpegImage;
  Mon: TMonitor;
  ScreenDC: HDC;
  xe2,ye2,xe,ye,xe1,ye1:integer;
  w1,w2,h1,h2:integer;

  mr,mg,mb:integer;
  mSize:integer;
  ic1:LongInt;

  ir1,ig1,ib1:integer;
  ir2,ig2,ib2:integer;

  mx,my:integer;

 // label 3;

begin

mSize:=20;








  //Jpg := TJpegImage.Create;
  ScreenDC := GetDC(0);
  try

//      form2.img1.Picture.bitmap.PixelFormat:=pf24bit;
      i:=0;//mon_index1;
      Mon := Screen.Monitors[0];
      form2.img1.Picture.bitmap.Width := Mon.Width;
      form2.img1.Picture.bitmap.Height := Mon.Height;
      BitBlt(form2.img1.Picture.bitmap.Canvas.Handle,
             0, 0,
             form2.img1.Picture.bitmap.Width, form2.img1.Picture.bitmap.Height,
             ScreenDC, Mon.Left, Mon.Top, SRCCOPY);

      form2.img1.Picture.bitmap.PixelFormat:=pf24bit;



       mx:=mouse.CursorPos.x;
       my:=mouse.CursorPos.y;
       form2.img1.picture.Bitmap.canvas.Pen.Color:=rgbToColor(0,0,0);
       form2.img1.picture.Bitmap.Canvas.Polygon([Classes.Point(mx,my),
                                                         Classes.Point(mx+mSize*0,my+mSize*0),
                                                         Classes.Point(mx,my+mSize*0)]);











      //Курсор мыши

      if check_mouseView.Checked then begin

                     mx:=mouse.CursorPos.x;
                     my:=mouse.CursorPos.y;

                     form2.img1.picture.Bitmap.canvas.Pen.Color:=rgbToColor(0,0,0);


                     form2.img1.picture.Bitmap.Canvas.Polygon([Classes.Point(mx,my),
                                                         Classes.Point(mx+mSize,my+trunc(mSize/sqrt(2))),
                                                         Classes.Point(mx,my+mSize)]);


                     end;





      //form2.img1.Picture.Bitmap.Assign(img1.Picture.bitmap);




  finally



    ReleaseDC(0, ScreenDC);
  end;



end;

procedure TForm1.Check_AAChange(Sender: TObject);
begin
  if check_aa.Checked=true  then form2.img1.AntialiasingMode:=amOn;
  if check_aa.Checked=false then form2.img1.AntialiasingMode:=amOff;
end;

procedure TForm1.check_MouseViewChange(Sender: TObject);
begin
  form2.img1.picture.Bitmap.canvas.Pen.Color:=rgbToColor(0,0,0);
  form2.img1.picture.Bitmap.canvas.Brush.Color:=Shape1.Brush.Color;

  form2.MouseView:=check_MouseView.checked;

end;

procedure TForm1.check_propChange(Sender: TObject);
begin
  form2.proportions:=check_prop.checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if form1.left>1024 then form1.left:=500;
  first_timer:=true;
  timer1.Enabled:=true;
  form1.AutoSize:=true;
  timer1.interval:=1000;
end;

end.

