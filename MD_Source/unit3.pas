unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,windows;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button2: TButton;
    img1: TImage;
    Timer1: TTimer;

    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private

  public
  MouseView,Proportions:boolean;
  end;

var
  Form2: TForm2;
  MouseView,Proportions:boolean;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button2Click(Sender: TObject);
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
  dt1,dt2:tDateTime;
  fps:integer;
begin


dt1:=now;
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

      if mouseView then begin

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



dt2:=now;

fps:=trunc(    (dt2-dt1)*24*60*60*1000     );
form2.Caption:='Монитор начальника('+IntToStr(fps)+'ms)';

end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.Timer1Timer(Sender: TObject);
var mon_index1,mon_index2:integer;
    c:real;
    h1,w1:integer;
    mx,my,mSize:integer;
begin




mon_index1:=0;
mon_index2:=1;




if screen.MonitorCount<2 then exit;




//Смещение Form2 на нужный монитор
if (form2.left>screen.Monitors[mon_index2].Left+screen.Monitors[mon_index2].width)or
   (form2.Left+form2.width<screen.Monitors[mon_index2].Left+screen.Monitors[mon_index2].width) then begin
                          form2.Left:=screen.Monitors[mon_index2].Left;
                          form2.Width:=screen.Monitors[mon_index2].width;
                          form2.WindowState:=wsMaximized;
                          end;

//растягивание img1 на всю форму


c:=screen.Monitors[mon_index1].Width/screen.Monitors[mon_index1].Height;


if c<0.0001 then exit;

if img1.left<>0 then img1.Left:=0;
if img1.Width<>form2.ClientWidth then img1.Width:=form2.ClientWidth;


if proportions=false then h1:=form2.ClientHeight;


if proportions=true then h1:=trunc(img1.width/c);


if img1.height<>h1 then img1.Height:=h1;


my:=trunc(form2.ClientHeight/2-h1/2);
if img1.Top<>my then img1.Top:=trunc(form2.ClientHeight/2-h1/2);


form2.WindowState:=wsMaximized;
//if form2.WindowState<>wsMaximized then form2.WindowState:=wsMaximized;



Button2Click(Button2);//Перерисовка изображения



end;

end.

