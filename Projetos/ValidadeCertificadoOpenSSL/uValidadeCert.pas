unit uValidadeCert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    BitBtn5: TBitBtn;
    OpenDialog_Certificado: TOpenDialog;
    StatusBar1: TStatusBar;
    function  ValidadeCertificado(wCertificado, wSenha: string): string;
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses ShellAPI;
{$R *.dfm}

function TForm1.ValidadeCertificado(wCertificado, wSenha: string): string;
   function Months(wM:string): string;
   begin
      wM:=UpperCase(wM);
      if wM='JAN' then
         Result:='1'
      else if wM='FEB' then
         Result:='2'
      else if wM='MAR' then
         Result:='3'
      else if wM='APR' then
         Result:='4'
      else if wM='MAY' then
         Result:='5'
      else if wM='JUN' then
         Result:='6'
      else if wM='JUL' then
         Result:='7'
      else if wM='AUG' then
         Result:='8'
      else if wM='SEP' then
         Result:='9'
      else if wM='OCT' then
         Result:='10'
      else if wM='NOV' then
         Result:='11'
      else if wM='DEC' then
         Result:='12';
   end;

   procedure Delay(msecs:integer);
   var
      FirstTickCount : longint;
   begin
      FirstTickCount:=GetTickCount;
      repeat
         Application.ProcessMessages;
      until ((GetTickCount-FirstTickCount) >= Longint(msecs));
   end;
var
   strFile: TextFile;
   strLine: String;
   wPos: integer;
   wDiretorio_Padrao: string;
   wComando: string;
   cExe, cArq1, cArq2: string;
begin
   Result:='';
   Screen.Cursor:=crHourGlass;

   try
      //diretorio padrao
      wDiretorio_Padrao := ExtractFilePath(Application.ExeName);
      cExe := '"'+wdiretorio_padrao+'openssl.exe"';

      //cópia arquivo PFX
      CopyFile(PWideChar(wcertificado),PWideChar(wdiretorio_padrao+'certificado.pfx'),true);

      //converte pfx para pem
      //wComando := wdiretorio_padrao+'openssl pkcs12 -in '+wdiretorio_padrao+'certificado.pfx -out '+wdiretorio_padrao+'certificado.pem -nokeys -passin pass:'+wSenha;
      //WinExec(PAnsiChar(AnsiString(wComando)),0);
      //Delay(5000); //para dar tempo do arquivo ficar disponivel para uso

      cArq1 := '"'+wdiretorio_padrao+'certificado.pfx "';
      cArq2 := '"'+wdiretorio_padrao+'certificado.pem "';

      wComando := ' pkcs12 -in '+cArq1+' -out '+cArq2+' -nokeys -passin pass:'+wSenha;
      ShellExecute(Handle,NIL,PChar(cExe), PChar(wComando),nil,0);
      Delay(5000); //para dar tempo do arquivo ficar disponivel para uso

      //extrai informacoes do certificado
      //wComando:=wdiretorio_padrao+'openssl x509 -enddate -in '+wdiretorio_padrao+'certificado.pem -text -out '+wdiretorio_padrao+'validade.txt';
      //WinExec(PAnsiChar(AnsiString(wComando)),0);
      //Delay(5000); //para dar tempo do arquivo ficar disponivel para uso

      cArq1 := '"'+wdiretorio_padrao+'certificado.pem "';
      cArq2 := '"'+wdiretorio_padrao+'validade.txt "';

      wComando := ' x509 -enddate -in '+cArq1+' -text -out '+cArq2;
      ShellExecute(Handle,NIL,PChar(cExe), PChar(wComando),nil,0);
      Delay(5000); //para dar tempo do arquivo ficar disponivel para uso

      //Lê arquivo
      if FileExists(wdiretorio_padrao+'validade.txt') then
      begin
         AssignFile(strFile, wdiretorio_padrao+'validade.txt');
         Reset(strFile);
         while not EOF(strFile) do
         begin
            Readln(strFile, strLine);
            wPos:=Pos('NOT AFTER :',UpperCase(strline));
            if (wPos <> 0) then
            begin
               Result:=trim(copy(strLine,wPos+11,25));
               Break;
            end;
         end;
         CloseFile(strFile);

         //identica data corretamente dd/mm/aaaa
         Result:=DateToStr(StrToDate(copy(Result,5,2)+'/'+
                                     Months(copy(Result,1,3))+'/'+
                                     copy(Result,17,4)));
      end
   except
   end;

   //apaga arquivos criados
   if FileExists(wdiretorio_padrao+'validade.txt') then
      DeleteFile(wdiretorio_padrao+'validade.txt');
   if FileExists(wdiretorio_padrao+'certificado.pem') then
      DeleteFile(wdiretorio_padrao+'certificado.pem');
   if FileExists(wdiretorio_padrao+'certificado.pfx') then
      DeleteFile(wdiretorio_padrao+'certificado.pfx');

   Screen.Cursor:=crDefault;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
   wsenha: string;
   wvalidade: string;
begin
   if (OpenDialog_Certificado.Execute) then
   begin
      if InputQuery('Certificado foi carregado com Sucesso','Digite a senha do certificado:',wsenha) then
      begin
         if (length(wsenha)>0) then
         begin
            //descobrir validade do certificado
            StatusBar1.Panels[0].Text:='Identificando Validade do Certificado. Aguarde...';
            wvalidade:=ValidadeCertificado(OpenDialog_Certificado.FileName,wsenha);

            if length(wvalidade)<=0 then
               StatusBar1.Panels[0].Text:='Erro ao Identificar a Validade do Certificado...'
            else
               StatusBar1.Panels[0].Text:='Validade do Certificado: '+wvalidade;
         end;
      end;
   end;
end;

end.
