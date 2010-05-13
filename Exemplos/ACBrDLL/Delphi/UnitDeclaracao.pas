unit UnitDeclaracao;

interface

{$IFDEF MSWINDOWS}
function DefineModelo(ModeloStr, Porta : String ; Timeout : Integer ): Boolean; stdcall; External 'ACBrECFDLL.DLL';
function IdentificaConsumidor( CPF_CNPJ : String; Nome : String = ''; Endereco : String = '') : Integer ; stdcall;  External 'ACBrECFDLL.DLL';
Function AbreCupom( CPF_CNPJ : String = ''; Nome : String = '';
                    Endereco : String = '') : Integer ; stdcall; External 'ACBrECFDLL.DLL';
Function VendeItem( Codigo, Descricao : String; AliquotaICMS : String;
                    Qtd : Double ; ValorUnitario : Double; DescontoPorc : Double = 0;
                    Unidade : String = ''; TipoDescontoAcrescimo : String = '%') : Integer ; stdcall; External 'ACBrECFDLL.DLL';
Function SubtotalizaCupom( DescontoAcrescimo : Double = 0;
                             MensagemRodape : String = '') : Integer ; stdcall ; External 'ACBrECFDLL.DLL';
Function EfetuaPagamento( CodFormaPagto : String; Valor : Double;
                           Observacao : String = ''; ImprimeVinculado : Boolean = false) : Integer ; stdcall ; External 'ACBrECFDLL.DLL';
Function FechaCupom( Observacao : String = '') : Integer ; stdcall ; External 'ACBrECFDLL.DLL';
Function LeituraX : Integer ; stdcall ;  External 'ACBrECFDLL.DLL';
Function ReducaoZ( DataHora : TDateTime = 0 ) : Integer ; stdcall ; External 'ACBrECFDLL.DLL';
Function CancelaCupom  : Integer ; stdcall ;  External 'ACBrECFDLL.DLL';
Function CancelaItemVendido( NumItem : Integer ) : Integer ; stdcall ;  External 'ACBrECFDLL.DLL';
{$ENDIF}

{$IFDEF LINUX}
function DefineModelo(ModeloStr, Porta : String ; Timeout : Integer ): Boolean; cdecl; External 'libACBrECFDLL.so';
function IdentificaConsumidor( CPF_CNPJ : String; Nome : String = ''; Endereco : String = '') : Integer ; cdecl;  External 'libACBrECFDLL.so';
Function AbreCupom( CPF_CNPJ : String = ''; Nome : String = '';
                    Endereco : String = '') : Integer ; cdecl; External 'libACBrECFDLL.so';
Function VendeItem( Codigo, Descricao : String; AliquotaICMS : String;
                    Qtd : Double ; ValorUnitario : Double; DescontoPorc : Double = 0;
                    Unidade : String = ''; TipoDescontoAcrescimo : String = '%') : Integer ; cdecl; External 'libACBrECFDLL.so';
Function SubtotalizaCupom( DescontoAcrescimo : Double = 0;
                             MensagemRodape : String = '') : Integer ; cdecl ; External 'libACBrECFDLL.so';
Function EfetuaPagamento( CodFormaPagto : String; Valor : Double;
                           Observacao : String = ''; ImprimeVinculado : Boolean = false) : Integer ; cdecl ; External 'libACBrECFDLL.so';
Function FechaCupom( Observacao : String = '') : Integer ; cdecl ; External 'libACBrECFDLL.so';
Function LeituraX : Integer ; cdecl ;  External 'libACBrECFDLL.so';
Function ReducaoZ( DataHora : TDateTime = 0 ) : Integer ; cdecl ; External 'libACBrECFDLL.so';
Function CancelaCupom  : Integer ; cdecl ;  External 'libACBrECFDLL.so';
Function CancelaItemVendido( NumItem : Integer ) : Integer ; cdecl ;  External 'libACBrECFDLL.so';
{$ENDIF}

implementation

end.
