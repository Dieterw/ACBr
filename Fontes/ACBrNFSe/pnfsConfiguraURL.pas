unit pnfsConfiguraURL;

interface

uses
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnLeitor;

type

 TInfMun = class(TPersistent)
  private
    // Municipio
    FcMun: Integer;
    FxMun: String;
    Fprovedor: String;
    FsoapVersion: String;
    FtimeOut: Integer;
    FvalidaCertificadoWS: Boolean;
    // URLs de Homologação
    FhRecepcaoLoteRPS: String;
    FhConsultaLoteRPS: String;
    FhConsultaNFSeRPS: String;
    FhConsultaSitLoteRPS: String;
    FhConsultaNFSe: String;
    FhCancelaNFSe: String;
    // URLs de Produção
    FpRecepcaoLoteRPS: String;
    FpConsultaLoteRPS: String;
    FpConsultaNFSeRPS: String;
    FpConsultaSitLoteRPS: String;
    FpConsultaNFSe: String;
    FpCancelaNFSe: String;
  public
    // Municipio
    property cMun: Integer                read FcMun                write FcMun;
    property xMun: String                 read FxMun                write FxMun;
    property provedor: String             read Fprovedor            write Fprovedor;
    property soapVersion: String          read FsoapVersion         write FsoapVersion;
    property timeOut: Integer             read FtimeOut             write FtimeOut;
    property validaCertificadoWS: Boolean read FvalidaCertificadoWS write FvalidaCertificadoWS;
    // URLs de Homologação
    property hRecepcaoLoteRPS: String    read FhRecepcaoLoteRPS    write FhRecepcaoLoteRPS;
    property hConsultaLoteRPS: String    read FhConsultaLoteRPS    write FhConsultaLoteRPS;
    property hConsultaNFSeRPS: String    read FhConsultaNFSeRPS    write FhConsultaNFSeRPS;
    property hConsultaSitLoteRPS: String read FhConsultaSitLoteRPS write FhConsultaSitLoteRPS;
    property hConsultaNFSe: String       read FhConsultaNFSe       write FhConsultaNFSe;
    property hCancelaNFSe: String        read FhCancelaNFSe        write FhCancelaNFSe;
    // URLs de Produção
    property pRecepcaoLoteRPS: String    read FpRecepcaoLoteRPS    write FpRecepcaoLoteRPS;
    property pConsultaLoteRPS: String    read FpConsultaLoteRPS    write FpConsultaLoteRPS;
    property pConsultaNFSeRPS: String    read FpConsultaNFSeRPS    write FpConsultaNFSeRPS;
    property pConsultaSitLoteRPS: String read FpConsultaSitLoteRPS write FpConsultaSitLoteRPS;
    property pConsultaNFSe: String       read FpConsultaNFSe       write FpConsultaNFSe;
    property pCancelaNFSe: String        read FpCancelaNFSe        write FpCancelaNFSe;
  end;

 TretInfMun = class(TPersistent)
  private
    FLeitor: TLeitor;
    FInfMun: TinfMun;
    FcMun: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property infMun: TinfMun read FinfMun write FinfMun;
    property cMun: Integer   read FcMun   write FcMun;
  end;

implementation

{ TretInfMun }

constructor TretInfMun.Create;
begin
  FLeitor := TLeitor.Create;
  FinfMun := TinfMun.Create;
end;

destructor TretInfMun.Destroy;
begin
  FLeitor.Free;
  FinfMun.Free;
  inherited;
end;

function TretInfMun.LerXml: boolean;
var
  i: Integer;
  Ok: Boolean;
begin
  Ok := False;

  try
    Leitor.Grupo := Leitor.Arquivo;
    i := 0;
    while (Leitor.rExtrai(1, 'Municipio', '', i + 1) <> '') and not Ok do
     begin
      infMun.FcMun                := Leitor.rCampo(tcInt, 'cMun');
      infMun.FxMun                := Leitor.rCampo(tcStr, 'xMun');
      infMun.Fprovedor            := Leitor.rCampo(tcStr, 'provedor');
      infMun.FsoapVersion         := Leitor.rCampo(tcStr, 'soapVersion');
      infMun.FtimeOut             := Leitor.rCampo(tcInt, 'timeOut');
      if Leitor.rCampo(tcStr, 'validaCertificadoWS') = 'false'
       then infMun.FvalidaCertificadoWS := False
       else infMun.FvalidaCertificadoWS := True;

      if infMun.FcMun = FcMun
       then begin
        // Ler URLs de Homologação
        if leitor.rExtrai(2, 'homologacao') <> ''
         then begin
          infMun.FhRecepcaoLoteRPS    := Leitor.rCampo(tcStr, 'RecepcaoLoteRPS');
          infMun.FhConsultaLoteRPS    := Leitor.rCampo(tcStr, 'ConsultaLoteRPS');
          infMun.FhConsultaNFSeRPS    := Leitor.rCampo(tcStr, 'ConsultaNFSeRPS');
          infMun.FhConsultaSitLoteRPS := Leitor.rCampo(tcStr, 'ConsultaSitLoteRPS');
          infMun.FhConsultaNFSe       := Leitor.rCampo(tcStr, 'ConsultaNFSe');
          infMun.FhCancelaNFSe        := Leitor.rCampo(tcStr, 'CancelaNFSe');
         end;
        // Ler URLs de Produção
        if leitor.rExtrai(2, 'producao') <> ''
         then begin
          infMun.FpRecepcaoLoteRPS    := Leitor.rCampo(tcStr, 'RecepcaoLoteRPS');
          infMun.FpConsultaLoteRPS    := Leitor.rCampo(tcStr, 'ConsultaLoteRPS');
          infMun.FpConsultaNFSeRPS    := Leitor.rCampo(tcStr, 'ConsultaNFSeRPS');
          infMun.FpConsultaSitLoteRPS := Leitor.rCampo(tcStr, 'ConsultaSitLoteRPS');
          infMun.FpConsultaNFSe       := Leitor.rCampo(tcStr, 'ConsultaNFSe');
          infMun.FpCancelaNFSe        := Leitor.rCampo(tcStr, 'CancelaNFSe');
         end;
        Ok := True;
       end;
      inc(i);
     end;
    result := True;
  except
    result := False;
  end;
end;

end.

