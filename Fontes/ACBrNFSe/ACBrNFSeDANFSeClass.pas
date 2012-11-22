unit ACBrNFSeDANFSeClass;

interface

uses
 Forms, SysUtils, Classes,
 pnfsNFSe, pnfsConversao;

type

 TACBrNFSeDANFSeClass = class( TComponent )
  private
    procedure SetNFSe(const Value: TComponent);
    procedure ErroAbstract( NomeProcedure: String );
    function GetPathArquivos: String;
  protected
    FACBrNFSe: TComponent;
    FLogo: String;
    FSistema: String;
    FUsuario: String;
    FPathArquivos: String;
    FImpressora: String;
    FMostrarPreview: Boolean;
    FMostrarStatus: Boolean;
    FNumCopias: Integer;
    FExpandirLogoMarca: Boolean;
    FFax : String;
    FSite: String;
    FEmail: String;
    FMargemInferior: Double;
    FMargemSuperior: Double;
    FMargemEsquerda: Double;
    FMargemDireita: Double;
    FPrestLogo: String;
    FPrefeitura: String;
    FNFSeCancelada: boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe: TNFSe = nil); virtual;
    procedure ImprimirDANFSePDF(NFSe: TNFSe = nil); virtual;
  published
    property ACBrNFSe: TComponent  read FACBrNFSe write SetNFSe;
    property Logo: String read FLogo write FLogo;
    property Sistema: String read FSistema write FSistema;
    property Usuario: String read FUsuario write FUsuario;
    property PathPDF: String read GetPathArquivos write FPathArquivos ;
    property Impressora: String read FImpressora write FImpressora;
    property MostrarPreview: Boolean read FMostrarPreview write FMostrarPreview;
    property MostrarStatus: Boolean read FMostrarStatus write FMostrarStatus;
    property NumCopias: Integer read FNumCopias write FNumCopias;
    property ExpandirLogoMarca: Boolean read FExpandirLogoMarca write FExpandirLogoMarca default false;
    property Fax : String read FFax   write FFax;
    property Site: String read FSite  write FSite;
    property Email: String read FEmail write FEmail;
    property MargemInferior: Double read FMargemInferior write FMargemInferior;
    property MargemSuperior: Double read FMargemSuperior write FMargemSuperior;
    property MargemEsquerda: Double read FMargemEsquerda write FMargemEsquerda;
    property MargemDireita: Double read FMargemDireita write FMargemDireita;
    property PrestLogo: String read FPrestLogo write FPrestLogo;
    property Prefeitura: String read FPrefeitura write FPrefeitura;
    property NFSeCancelada: Boolean read FNFSeCancelada write FNFSeCancelada;
  end;

implementation

uses
 ACBrNFSe, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil;

{ TACBrNFSeDANFSeClass }

constructor TACBrNFSeDANFSeClass.Create(AOwner: TComponent);
begin
 inherited create( AOwner );

 FACBrNFSe       := nil;
 FLogo           := '';
 FSistema        := '';
 FUsuario        := '';
 FPathArquivos   := '';
 FImpressora     := '';
 FMostrarPreview := True;
 FMostrarStatus  := True;
 FNumCopias      := 1;
 FFax            := '';
 FSite           := '';
 FEmail          := '';
 FMargemInferior := 0.8;
 FMargemSuperior := 0.8;
 FMargemEsquerda := 0.6;
 FMargemDireita  := 0.51;
 FPrestLogo      := '';
 FPrefeitura     := '';
 FNFSeCancelada  := False;
end;

destructor TACBrNFSeDANFSeClass.Destroy;
begin

 inherited Destroy;
end;

procedure TACBrNFSeDANFSeClass.ErroAbstract(NomeProcedure: String);
begin
 raise Exception.Create( NomeProcedure );
end;

function TACBrNFSeDANFSeClass.GetPathArquivos: String;
begin
 if DFeUtil.EstaVazio(FPathArquivos)
  then if Assigned(FACBrNFSe)
        then FPathArquivos := TACBrNFSe(FACBrNFSe).Configuracoes.Geral.PathSalvar;

 if DFeUtil.NaoEstaVazio(FPathArquivos)
  then if not DirectoryExists(FPathArquivos)
        then ForceDirectories(FPathArquivos);

 Result := PathWithDelim(FPathArquivos);
end;

procedure TACBrNFSeDANFSeClass.ImprimirDANFSe(NFSe: TNFSe);
begin
 ErroAbstract('Imprimir');
end;

procedure TACBrNFSeDANFSeClass.ImprimirDANFSePDF(NFSe: TNFSe);
begin
 ErroAbstract('ImprimirPDF');
end;

procedure TACBrNFSeDANFSeClass.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
 inherited Notification(AComponent, Operation);

 if (Operation = opRemove) and (FACBrNFSe <> nil) and (AComponent is TACBrNFSe)
  then FACBrNFSe := nil;
end;

procedure TACBrNFSeDANFSeClass.SetNFSe(const Value: TComponent);
var
 OldValue: TACBrNFSe;
begin
 if Value <> FACBrNFSe then
  begin
   if Value <> nil
    then if not (Value is TACBrNFSe)
          then raise Exception.Create('ACBrDANFSe.NFSe deve ser do tipo TACBrNFSe');

   if Assigned(FACBrNFSe)
    then FACBrNFSe.RemoveFreeNotification(Self);

   OldValue  := TACBrNFSe(FACBrNFSe);  // Usa outra variavel para evitar Loop Infinito
   FACBrNFSe := Value;                 // na remoção da associação dos componentes

   if Assigned(OldValue)
    then if Assigned(OldValue.DANFSe)
          then OldValue.DANFSe := nil;

   if Value <> nil
    then begin
     Value.FreeNotification(self);
     TACBrNFSe(Value).DANFSe := self;
    end;
  end;
end;

end.
