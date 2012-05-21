unit uACBrDanfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, RLConsts,
  Dialogs, ACBrNFeDANFEClass, ACBrNFeDANFERaveCB, ACBrNFe, IniFiles, ExtCtrls,
  ACBrNFeUtil, pcnConversao, ACBrNFeDANFeRLClass, ACBrNFeDANFERave, ACBrNFeDANFeRL;

type
  Tfrm_danfe = class(TForm)
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFERaveCB1: TACBrNFeDANFERaveCB;
    Panel1: TPanel;
    TrayIcon1: TTrayIcon;
    Timer1: TTimer;
    Image1: TImage;
    ACBrNFeDANFERave1: TACBrNFeDANFERave;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    function  Configuracao: boolean;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    const
      wArquivoINI: string =
'[DANFe]'+#13+
'# DANFe                          = Rave'+#13+
'# DANFe                          = Fortes'+#13+
'DANFe                          = RaveCB'+#13+
#13+
'[PROPRIEDADES_DANFe]'+#13+
'CasasDecimais_Qtde             = 2'+#13+
'CasasDecimais_Unidade          = 2'+#13+
'CasasDecimais_Mask_Qtde        ='+#13+
'CasasDecimais_Mask_Unidade     ='+#13+
'Email                          ='+#13+
'ExibirResumoCanhoto            = 0'+#13+
'ExibirResumoCanhoto_Texto      ='+#13+
'ExpandirLogoMarca              = 0'+#13+
'Fax                            ='+#13+
'FormularioContinuo             = 0'+#13+
'Impressora                     ='+#13+
'ImprimirDescPorc               = 0'+#13+
'ImprimirTotalLiquido           = 0'+#13+
'Logo                           ='+#13+
'MargemDireita                  = 0,51'+#13+
'MargemEsquerda                 = 0,6'+#13+
'MargemInferior                 = 0,8'+#13+
'MargemSuperior                 = 0,8'+#13+
'MostrarPreview                 = 1'+#13+
'MostrarStatus                  = 1'+#13+
'NumCopias                      = 1'+#13+
'PathPdf                        ='+#13+
'ProdutosPorPagina              = 0'+#13+
'ProtocoloNFe                   ='+#13+
'Sistema                        ='+#13+
'Site                           ='+#13+
'TamanhoFonte_DemaisCampos      = 10'+#13+
'# TipoDANFE                      = tiPaisagem'+#13+
'TipoDANFE                      = tiRetrato'+#13+
'Usuario                        ='+#13+
#13+
'[PROPRIEDADEs_DANFe_RAVE]'+#13+
'EspessuraBorda                 = 1'+#13+
'ImprimirDetalhamentoEspecifico = 1'+#13+
'TamanhoFonte_RazaoSocial       = 12'+#13+
'TamanhoFonte_ANTT              = 10'+#13+
#13+
'[PROPRIEDADEs_DANFe_RAVECB]'+#13+
'EspessuraBorda                 = 2'+#13+
'# Fonte                          = ftCourier'+#13+
'Fonte                          = ftTimes'+#13+
'ImprimirDetalhamentoEspecifico = 1'+#13+
'TamanhoCampoCodigo             = 0'+#13+
'TamanhoFonte_ANTT              = 10'+#13+
#13+
'[PROPRIEDADEs_DANFe_FORTES]'+#13+
'# FonteDANFE                     = fdArial'+#13+
'# FonteDANFE                     = fdCourierNew'+#13+
'FonteDANFE                     = fdTimesNewRoman'+#13+
'LarguraCodProd                 = 0'+#13+
'MarcadAgua                     ='+#13+
'# PosCanhoto                     = pcRodape'+#13+
'PosCanhoto                     = pcCabecalho'+#13+
'TamanhoFonte_RazaoSocial       = 12';

  public
    { Public declarations }
    wPDF: boolean;
    wNFeCancelada: boolean;
  end;

var
  frm_danfe: Tfrm_danfe;

implementation

{$R *.dfm}

function Tfrm_danfe.Configuracao: boolean;
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
   Ini: TIniFile;
   wString: TStringList;
   wDanfe: string;
   IniFile : string;
begin
   result:=false;

   IniFile := ExtractFilePath(Application.ExeName)+'ACBrDANFe.ini';
   try
      wString:=TStringList.Create;
      if not FileExists(IniFile) then
      begin
         wString.Text:=wArquivoINI;
         wString.SaveToFile(IniFile);
         Delay(3000);
      end;

      Ini:=TIniFile.Create(IniFile);
      try
         wDanfe := Trim(Ini.ReadString('DANFe','DANFe' ,'RaveCB'));
         if wDanfe='Rave' then
            ACBrNFe1.DANFE := ACBrNFeDANFeRave1
         else if wDanfe='RaveCB' then
            ACBrNFe1.DANFE := ACBrNFeDANFeRaveCB1
         else if wDanfe='Fortes' then
            ACBrNFe1.DANFE := ACBrNFeDANFeRL1;

         with ACBrNFe1.DANFE do
         begin
            CasasDecimais._qCom            := Ini.ReadInteger('PROPRIEDADES_DANFe','CasasDecimais_Qtde' ,2);
            CasasDecimais._vUnCom          := Ini.ReadInteger('PROPRIEDADES_DANFe','CasasDecimais_Unidade' ,2);
            CasasDecimais._Mask_qCom       := Trim(Ini.ReadString('PROPRIEDADES_DANFe','CasasDecimais_Mask_Qtde' ,''));
            CasasDecimais._Mask_vUnCom     := Trim(Ini.ReadString('PROPRIEDADES_DANFe','CasasDecimais_Mask_Unidade' ,''));
            Email                          := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Email' ,''));
            ExibirResumoCanhoto            := Ini.ReadBool('PROPRIEDADES_DANFe','ExibirResumoCanhoto' ,false);
            ExibirResumoCanhoto_Texto      := Trim(Ini.ReadString('PROPRIEDADES_DANFe','ExibirResumoCanhoto_Texto' ,''));
            ExpandirLogoMarca              := Ini.ReadBool('PROPRIEDADES_DANFe','ExpandirLogoMarca' ,false);
            Fax                            := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Fax' ,''));
            FormularioContinuo             := Ini.ReadBool('PROPRIEDADES_DANFe','FormularioContinuo' ,false);
            Impressora                     := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Impressora' ,''));
            ImprimirDescPorc               := Ini.ReadBool('PROPRIEDADES_DANFe','ImprimirDescPorc' ,false);
            ImprimirTotalLiquido           := Ini.ReadBool('PROPRIEDADES_DANFe','ImprimirTotalLiquido' ,false);
            Logo                           := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Logo' ,''));
            MargemDireita                  := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemDireita' ,0.51);
            MargemEsquerda                 := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemEsquerda' ,0.6);
            MargemInferior                 := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemInferior' ,0.8);
            MargemSuperior                 := Ini.ReadFloat('PROPRIEDADES_DANFe','MargemSuperior' ,0.8);
            MostrarPreview                 := Ini.ReadBool('PROPRIEDADES_DANFe','MostrarPreview' ,true);
            MostrarStatus                  := Ini.ReadBool('PROPRIEDADES_DANFe','MostrarStatus' ,true);
            NumCopias                      := Ini.ReadInteger('PROPRIEDADES_DANFe','NumCopias' ,1);
            PathPdf                        := Trim(Ini.ReadString('PROPRIEDADES_DANFe','PathPdf' ,''));
            ProdutosPorPagina              := Ini.ReadInteger('PROPRIEDADES_DANFe','ProdutosPorPagina' ,0);
            ProtocoloNFe                   := Trim(Ini.ReadString('PROPRIEDADES_DANFe','ProtocoloNFe' ,''));
            Sistema                        := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Sistema' ,''));
            Site                           := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Site' ,''));
            TamanhoFonte_DemaisCampos      := Ini.ReadInteger('PROPRIEDADES_DANFe','TamanhoFonte_DemaisCampos' ,10);
            TipoDANFE                      := NotaUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe','TipoDANFE' ,'tiRetrato'))='tiRetrato',tiRetrato, tiPaisagem);
            Usuario                        := Trim(Ini.ReadString('PROPRIEDADES_DANFe','Usuario' ,''));
         end;

         with ACBrNFeDANFeRave1 do
         begin
            EspessuraBorda                 := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','EspessuraBorda' ,2);
            ImprimirDetalhamentoEspecifico := Ini.ReadBool('PROPRIEDADES_DANFe_RAVE','ImprimirDetalhamentoEspecifico' ,true);
            RavFile                        := ExtractFilePath(Application.ExeName)+'DANFE_Rave513.rav';
            TamanhoFonte_RazaoSocial       := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','TamanhoFonte_RazaoSocial' ,12);
            TamanhoFonte_ANTT              := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','TamanhoFonte_ANTT' ,10);
         end;

         with ACBrNFeDANFeRaveCB1 do
         begin
            EspessuraBorda                 := Ini.ReadInteger('PROPRIEDADEs_DANFe_RAVECB','EspessuraBorda' ,2);
            Fonte                          := NotaUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_RAVECB','Fonte' ,'ftTimes'))='ftTimes',ftTimes, ftCourier);
            ImprimirDetalhamentoEspecifico := Ini.ReadBool('PROPRIEDADEs_DANFe_RAVECB','ImprimirDetalhamentoEspecifico' ,true);
            TamanhoCampoCodigo             := Ini.ReadInteger('PROPRIEDADEs_DANFe_RAVECB','TamanhoCampoCodigo' ,10);
            TamanhoFonte_ANTT              := Ini.ReadInteger('PROPRIEDADES_DANFe_RAVE','TamanhoFonte_ANTT' ,10);
         end;

         with ACBrNFeDANFeRL1 do
         begin
            FonteDANFE                     := NotaUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FORTES','FonteDANFE' ,'fdTimesNewRoman'))='fdTimesNewRoman',fdTimesNewRoman,
                                                               NotaUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FORTES','FonteDANFE' ,'fdCourierNew'))='fdCourierNew',fdCourierNew,
                                                               fdArial));
            LarguraCodProd                 := Ini.ReadInteger('PROPRIEDADEs_DANFe_FORTES','LarguraCodProd' ,0);
            MarcadAgua                     := Trim(Ini.ReadString('PROPRIEDADES_DANFe_FORTES','MarcadAgua' ,''));
            PosCanhoto                     := NotaUtil.SeSenao(Trim(Ini.ReadString('PROPRIEDADEs_DANFe_FORTES','PosCanhoto' ,'pcCabecalho'))='pcCabecalho',pcCabecalho,pcRodape);
            TamanhoFonte_RazaoSocial       := Ini.ReadInteger('PROPRIEDADES_DANFe_FORTES','TamanhoFonte_RazaoSocial' ,12);
         end;

         Result:=True;
      except
         on EXC: Exception do
         begin
            MessageDlg('Erro:'+#13#13+exc.message,mtError,[mbOk],0);
         end;
      end;
   finally
      wString.Free;
      Ini.Free;
   end;
end;

procedure Tfrm_danfe.FormCreate(Sender: TObject);
var
   wArquivo: string;
   wTemp: string;
begin
   if ParamCount <= 0 then
      MessageDlg('Informe um arquivo XML para impressão',mtError,[mbOk],0)
   else
   begin
      wArquivo:=ParamStr(1);
      if not FileExists(wArquivo) then
         MessageDlg('Arquivo '+wArquivo+' não Encontrado',mtError,[mbOk],0)
      else
      begin
         wPDF:=False;
         wNfeCancelada:=False;
         if (ParamCount > 1) then
         begin
            wtemp:=UpperCase(ParamStr(2));
            if wtemp='PDF' then
               wPDF:=true
            else if wtemp='C' then
               wNFeCancelada:=true;
            if (ParamCount > 2) then
            begin
               wtemp:=UpperCase(ParamStr(3));
               if wtemp='PDF' then
                  wPDF:=true
               else if wtemp='C' then
                  wNFeCancelada:=true;
            end;
         end;

         if Configuracao then
         begin
            try
               ACBrNFe1.DANFE.NFeCancelada := wNFeCancelada;
               ACBrNFe1.NotasFiscais.Clear;
               ACBrNFe1.NotasFiscais.LoadFromFile(wArquivo);

               if wPDF then
                  ACBrNFe1.NotasFiscais.ImprimirPDF
               else
                  ACBrNFe1.NotasFiscais.Imprimir;
            except on
               EXC:Exception do
               begin
                  MessageDlg('Erro:'+#13#13+exc.message,mtError,[mbOk],0);
               end;
            end;
         end;
      end;
   end;

   Timer1.Enabled:=True;
end;

procedure Tfrm_danfe.Timer1Timer(Sender: TObject);
begin
   Close;
end;

initialization
{
"Sistema não está de acordo com a versão do Fortesreport. Versão atual 3.69B."

Esta verificação existe para evitar que o projeto utilize uma outra
versão do Fortes Report que não a indicada, evitando problemas em
ambientes com vários desenvolvedores.
para resolver faça o seguinte:

Adcionar na uses do form principal na parte interface a unit RLConsts
e colocar o código abaixo no final da unit antes do end.(end final) }


  RLConsts.SetVersion(3,71,'B');

end.
