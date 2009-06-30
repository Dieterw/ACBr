unit ACBrNFeDANFEClass;

interface

uses Forms, SysUtils, Classes,
  pcnNFe, pcnConversao;

type
  TACBrNFeDANFEClass = class( TComponent )
   private
    procedure SetNFE(const Value: TComponent);
    procedure ErroAbstract( NomeProcedure : String ) ;
  protected
    FACBrNFe : TComponent;
    FLogo: String;
    FSistema:String;
    FUsuario:String;
    FPathArquivos : String;
    FImpressora : String;
    FImprimirHoraSaida : Boolean;
    FMostrarPreview : Boolean;
    FTipoDANFE : TpcnTipoImpressao;
    FNumCopias : Integer;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); virtual ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); virtual ;
  published
    property ACBrNFe : TComponent  read FACBrNFe write SetNFE ;
    property Logo: String read FLogo write FLogo ;
    property Sistema: String read FSistema write FSistema ;
    property Usuario: String read FUsuario write FUsuario ;
    property PathPDF: String read FPathArquivos write FPathArquivos ;
    property Impressora: String read FImpressora write FImpressora ;
    property ImprimirHoraSaida: Boolean read FImprimirHoraSaida write FImprimirHoraSaida ;
    property MostrarPreview: Boolean read FMostrarPreview write FMostrarPreview ;
    property TipoDANFE: TpcnTipoImpressao read FTipoDANFE write FTipoDANFE ;
    property NumCopias: Integer read FNumCopias write FNumCopias ;
  end;

implementation

uses ACBrNFe ;

constructor TACBrNFeDANFEClass.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  FACBrNFe      := nil ;
  FLogo         := '' ;
  FSistema      := '' ;
  FUsuario      := '' ;
  FPathArquivos := '' ;
  FImpressora   := '' ;
  FImprimirHoraSaida    := False;
  FMostrarPreview       := True;
  FNumCopias := 1;
end;

destructor TACBrNFeDANFEClass.Destroy;
begin

  inherited Destroy ;
end;

procedure TACBrNFeDANFEClass.ImprimirDANFE(NFE : TNFe = nil) ;
begin
  ErroAbstract('Imprimir');
end;

procedure TACBrNFeDANFEClass.ImprimirDANFEPDF(NFE : TNFe = nil) ;
begin
  ErroAbstract('ImprimirPDF');
end;

procedure TACBrNFeDANFEClass.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FACBrNFe <> nil) and (AComponent is TACBrNFe) then
     FACBrNFe := nil ;
end;

procedure TACBrNFeDANFEClass.SetNFE(const Value: TComponent);
  Var OldValue : TACBrNFe ;
begin
  if Value <> FACBrNFe then
  begin
     if Value <> nil then
        if not (Value is TACBrNFe) then
           raise Exception.Create('ACBrDANFERave.NFE deve ser do tipo TACBrNFe') ;

     if Assigned(FACBrNFe) then
        FACBrNFe.RemoveFreeNotification(Self);

     OldValue := TACBrNFe(FACBrNFe) ;   // Usa outra variavel para evitar Loop Infinito
     FACBrNFe := Value;                 // na remoção da associação dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.DANFE) then
           OldValue.DANFE := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        TACBrNFe(Value).DANFE := self ;
     end ;
  end ;
end;

procedure TACBrNFeDANFEClass.ErroAbstract(NomeProcedure: String);
begin
  raise Exception.Create( NomeProcedure ) ;
end;

end.
