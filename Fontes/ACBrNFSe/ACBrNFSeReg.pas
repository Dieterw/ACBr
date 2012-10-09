{$I ACBr.inc}

unit ACBrNFSeReg;

interface

uses
 SysUtils, Classes,
{$IFDEF VisualCLX}
 QDialogs,
{$ELSE}
 Dialogs, FileCtrl,
{$ENDIF}
{$IFDEF FPC}
  LResources, LazarusPackageIntf, PropEdits, componenteditors,
{$ELSE}
  {$IFNDEF COMPILER6_UP}
    DsgnIntf,
  {$ELSE}
    DesignIntf, DesignEditors,
  {$ENDIF}
{$ENDIF}
 ACBrNFSe, pnfsConversao;

type

 { Editor de Proriedades de Componente para mostrar o AboutACBr }
 TACBrAboutDialogProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

 { Editor de Proriedades de Componente para chamar OpenDialog }
 TACBrNFSeDirProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation

uses
 ACBrNFSeConfiguracoes;

{$IFNDEF FPC}
   {$R ACBrNFSe.dcr}
{$ENDIF}

procedure Register;
begin
 RegisterComponents('ACBr', [TACBrNFSe]);

 RegisterPropertyEditor(TypeInfo(TACBrNFSeAboutInfo), nil, 'AboutACBrNFSe',
     TACBrAboutDialogProperty);

 RegisterPropertyEditor(TypeInfo(TCertificadosConf), TConfiguracoes, 'Certificados',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TConfiguracoes), TACBrNFSe, 'Configuracoes',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TWebServicesConf), TConfiguracoes, 'WebServices',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TGeralConf), TConfiguracoes, 'Geral',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(String), TGeralConf, 'PathSalvar',
     TACBrNFSeDirProperty);

 RegisterPropertyEditor(TypeInfo(TArquivosConf), TConfiguracoes, 'Arquivos',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathNFSe',
     TACBrNFSeDirProperty);

 RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathCan',
     TACBrNFSeDirProperty);
end;

{ TACBrAboutDialogProperty }

procedure TACBrAboutDialogProperty.Edit;
begin
 ACBrAboutDialog;
end;

function TACBrAboutDialogProperty.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog, paReadOnly];
end;

function TACBrAboutDialogProperty.GetValue: string;
begin
 Result := 'Versão: ' + ACBRNFSE_VERSAO;
end;

{ TACBrNFSeDirProperty }

procedure TACBrNFSeDirProperty.Edit;
var
{$IFNDEF VisualCLX} Dir: String; {$ELSE} Dir: WideString; {$ENDIF}
begin
{$IFNDEF VisualCLX}
  Dir := GetValue;
  if SelectDirectory(Dir,[],0)
   then SetValue( Dir );
{$ELSE}
  Dir := '';
  if SelectDirectory('Selecione o Diretório','',Dir)
   then SetValue( Dir );
{$ENDIF}
end;

function TACBrNFSeDirProperty.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog];
end;

initialization

{$IFDEF FPC}
//   {$i ACBrNFSe_lcl.lrs}
{$ENDIF}

end.
