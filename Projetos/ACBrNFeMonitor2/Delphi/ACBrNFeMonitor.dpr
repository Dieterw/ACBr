program ACBrNFeMonitor;

uses
  Forms,
  Windows,
  RPDefine,
  SysUtils,
  IniFiles,
  ACBrNFeMonitor1 in 'ACBrNFeMonitor1.pas' {frmAcbrNfeMonitor},
  DoACBrNFeUnit in 'DoACBrNFeUnit.pas';

{$R *.res}
var 
   hMutex: THandle;
   Ini : TIniFile;
   UmaInstancia : Boolean;
 begin
   Ini := TIniFile.Create(  ExtractFilePath(Application.ExeName)+ 'ACBrNFeMonitor.ini' ) ;
   try
      UmaInstancia := Ini.ReadBool('ACBrNFeMonitor','Uma_Instancia',false);
   finally
      Ini.Free;
   end;

   if UmaInstancia then
    begin
      hMutex := CreateMutex(nil, true, PChar('ACBrNFeMonitor'));
      if (hMutex <> 0) and (GetLastError = 0) then
       begin
         RPDefine.DataID := IntToStr(Application.Handle);
         Application.Initialize;
         Application.CreateForm(TfrmAcbrNfeMonitor, frmAcbrNfeMonitor);
  Application.Run;
       end
      else
          MessageBox(0, 'ACBrNFeMonitor já está em execução!','ACBrNFeMonitor', mb_IconHand);
    end
   else
    begin
      RPDefine.DataID := IntToStr(Application.Handle);
      Application.Initialize;
      Application.CreateForm(TfrmAcbrNfeMonitor, frmAcbrNfeMonitor);
      Application.Run;
    end;
end.
