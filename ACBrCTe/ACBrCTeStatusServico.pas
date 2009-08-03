// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : D:\delphi\ACBr\trunk\ACBrCTe\wsdl\cteStatusServico.wsdl
// Encoding : utf-8
// Version  : 1.0
// (28/07/2009 20:53:20 - 1.33.2.5)
// ************************************************************************ //

unit ACBrCTeStatusServico;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico
  // binding   : CteStatusServicoSoap12
  // service   : CteStatusServico
  // port      : CteStatusServicoSoap12
  // ************************************************************************ //
  CteStatusServico = interface(IInvokable)
  ['{E75AF039-AF5D-31A0-9BD4-23E527E93890}']
    function  cteStatusServicoCT(const cteDadosMsg: WideString): WideString; stdcall;
  end;

function GetCteStatusServico(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CteStatusServico;


implementation

function GetCteStatusServico(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CteStatusServico;
const
  defWSDL = 'D:\delphi\ACBr\trunk\ACBrCTe\wsdl\cteStatusServico.wsdl';
  defURL  = '';
  defSvc  = 'CteStatusServico';
  defPrt  = 'CteStatusServicoSoap12';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as CteStatusServico);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(CteStatusServico), 'http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CteStatusServico), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CteStatusServico), ioDocument);

end.