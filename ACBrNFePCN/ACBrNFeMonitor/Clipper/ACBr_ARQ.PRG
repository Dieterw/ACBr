/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Projeto..: Rotinas xBase para o Monitor ACBr (Automacao Comercial Brasil).
 \ Programa.: ACBr_ARQ.PRG
 \ Descricao: Funcoes de Manipulacao de Arquivos (TXT / XML).
 \ Criacao..: 20/07/2009 - Direitos Autorais Reservados (c)
 \ Analista.: Riberto de Miranda Braz (RibertoBraz)
 \ Contactos: ribertobraz@hotmail.com (Email / MSN) ( +55 35 9922-0075 )
 \ Licenca..: Esta biblioteca e software livre; voce pode redistribui-la e/ou
 \            modifica-la sob os termos da Licenca Publica Geral Menor do GNU
 \            GNU conforme publicada pela Free Software Foundation;  tanto  a
 \            versao 2.1 da Licenca, ou  (a  seu  criterio)  qualquer  versao
 \            posterior.
 \
 \            Esta biblioteca e distribuida na expectativa de que seja  util,
 \            porem, SEM NENHUMA GARANTIA; nem mesmo a garantia implicita  de
 \            COMERCIABILIDADE OU ADEQUACAO A UMA FINALIDADE ESPECIFICA.
 \
 \            Consulte a  Licenca  Publica  Geral  Menor  do  GNU  para  mais
 \            detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)
 \
 \            Voce deve ter recebido uma copia da Licenca Publica Geral Menor
 \            do GNU junto com esta biblioteca; se nao, escreva para  a  Free
 \            Software Foundation, Inc., no endereco 59 Temple Street,  Suite
 \            330, Boston, MA 02111-1307 USA.
 \
 \            Voce tambem pode obter uma copia da licenca em:
 \            http://www.opensource.org/licenses/gpl-license.php
 \
 \            Voce pode obter a ultima versao  desse  arquivo  na  pagina  do
 \            Projeto ACBr Componentes localizado em:
 \            http://www.sourceforge.net/projects/acbr
 \
 \ Nota/Obs.: Todos os comandos de apoio retornam .t./.f. (true/false).
 \            Todos os comandos internos retornam "OK:" ou "ERRO:";
 \            ou retornam dados expecificos.
 \ Funcoes..: ARQ_INI() := Posiciona o Ponteiro no Inicio do Arquivo.
 \            ARQ_FIN() := Posiciona o Ponteiro no Final do Arquivo.
 \            ARQ_POS() := Retorna a Posicao Atual do ponteiro no Arquivo.
 \            ARQ_TAM() := Retorna o Tamanho do Arquivo em Bytes.
 \            ARQ_NEW() := Cria um novo Arquivo.
 \            ARQ_EXC() := Exclui um Arquivo.
 \            ARQ_LER() := Le um Arquivo, para recuperar informacoes.
 \            ARQ_PES() := Pesquisa Dados em um Arquivo para recuperar/trocar informacoes.
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Historico de Modificacoes:
 \
 \ 20/07/2009 - Codigo original por Riberto de Miranda Braz.
 \            * Programado manualmente pelo analista com base em exemplos.
 \ 02/08/2009 - Ribertode Miranda Braz. - (ribertobraz@hotmail.com)
 \            * Testando erros de criacao/gravacao de Arquivos.
 \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "ACBr.ch"   // inicializa constantes manifestas do sistema/ACBr.


/*
   Sintaxe: ARQ_TAM( <ExpC1> )
   Funcao.: Retorna o Tamanho do Arquivo em Bytes.
              ExpC1 = Arquivo a Verificar.
   Local..: Variaveis locais utilizadas.
              aFiles = Vetor retornado pelo comando "Directory".
   Retorna: Tamanho do Arquivo em Bytes.
*/
Function ARQ_TAM( cFile )
   LOCAL aFiles := Directory( iif( ValType(cFile) # "C", "", cFile) )

   If Len( aFiles ) > 0
      return aFiles[ 1 ][ 2 ]
   endif

return 0


/*
   Sintaxe: ARQ_INI( <ExpN1> )
   Funcao.: Posiciona o Ponteiro no Inicio do Arquivo.
              ExpN1 = Handler do Arquivo a posicionar.
   Retorna: Retorna a Posicao atual.
*/
Function ARQ_INI( nHan )
   // FS_SET
return Fseek( nHan, 0, 0 )


/*
   Sintaxe: ARQ_FIN( <ExpN1> )
   Funcao.: Posiciona o Ponteiro no Final do Arquivo.
              ExpN1 = Handler do Arquivo a posicionar.
   Retorna: Retorna a Posicao atual.
*/
Function ARQ_FIN( nHan )
   // FS_END
return Fseek( nHan, 0, 2 )


/*
   Sintaxe: ARQ_POS( <ExpN1> )
   Funcao.: Posiciona o Ponteiro no Final do Arquivo.
              ExpN1 = Handler do Arquivo a posicionar.
   Retorna: Retorna a Posicao atual.
*/
Function ARQ_POS( nHan )
   // FS_RELATIVE
return Fseek( nHan, 0, 1 )


/*
   Sintaxe: ARQ_NEW(<ExpC1> <,ExpC2> <,ExpN1>)
   Funcao.: Cria um novo Arquivo.
              ExpC1 = Arquivo para Criar.
              ExpC2 = Dados do Arquivo para Criar.
              ExpN1 = Tempo para Tentar CRIAR o Arquivo.
   Local..: Variaveis locais utilizadas.
              lRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
              cArq = Variavel de Criacao do Arquivo.
              nHan = Variavel "Handle DOS", do Arquivo Criado para identificacao.
              nSec = Tempo em Segundos (seconds) para tentativa de ACESSO aos Arquivos.
   Retorna: .t. se Ok.
*/
Function ARQ_NEW( cArq, cDad, nTmp )
   Local lRet := .t.   // Pensa positivo... Vai dar certo!
   Local nHan := -1    // Handle DOS. Faixa: 0...65535. (-1 eh Erro.)
   Local nSec := 0     // Nenhum tempo por enquanto.

   // Formata os Dados passados.
   if cArq = NIL    // Nao veio Arquivo para CRIAR?
      cArq := ""    // Nao vai CRIAR nenhum Arquivo...
      lRet := .f.   // entao retornaremos nao Ok (.f. - false).
   endif
   if cDad = NIL
      cDad := ""   // Cria um Arquivo vazio.
   endif
   if nTmp = NIL   // Nao veio o Tempo para tentar Gravar?
      nTmp := 0    // Entao definimos ZERO Segundo como Padrao.
   endif

   // Vamos CRIAR o Arquivo.
   if !empt( cArq )   // Tem algum arquivo para Criar?
      // Tenta CRIAR o Arquivo em ate "nTmp" segundos.
      nSec := seconds() + nTmp
      do while !File( cArq )       // Enquanto nao EXISTIR continuaremos
         nHan := FCreate( cArq )   // a tentar CRIAR.
         if FError() = 0   // Nao deu nenhum ERRO. Entao foi Criado o Arquivo.
            // Vamos Gravar/Escrever os Dados no arquivo.
            do while .t.   // Tentamos GRAVAR no Arquivo Criado.
               FWrite( nHan, cDad )
               if FError() = 0     // Conseguiu Gravar?
                  FClose( nHan )   // Fechamos o Arquivo.
                  if FError() = 0   // Conseguiu Fechar? (e escrever os buffers do Disco)
                     exit           // Entao Ok... Saimos.
                  endif    // Se nao conseguir, repetimos a operacao
               endif       // de Gravar/Fechar o Arquivo novamente.
               if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
                  lRet := .f.   // Entao nao consegue mesmo.
                  exit          // Saimos com o Erro de Gravacao.
               endif
            enddo
         else   // Deu erro? Nao conseguiu CRIAR?
            if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
               lRet := .f.   // Entao nao consegue mesmo; informa-mos o erro.
               exit          // Saimos... nao vamos tentar mais.
            endif
         endif
      enddo
   endif

return lRet


/*
   Sintaxe: ARQ_EXC(<ExpC1> <,ExpN1>)
   Funcao.: Exclui um Arquivo.
              ExpC1 = Arquivo para Excluir.
              ExpN1 = Tempo para Tentar EXCLUIR o Arquivo.
   Local..: Variaveis locais utilizadas.
              lRet = Variavel de Retorno.
   Retorna: .t. se Ok.
*/
Function ARQ_EXC( cArq, nTmp )
   LOCAL lRet := .t.   // Pensa positivo... Vai dar certo!

   // Formata os Dados passados.
   if cArq = NIL    // Nao veio Arquivo para EXCLUIR?
      cArq := ""    // Nao vai EXCLUIR nenhum Arquivo...
      lRet := .f.   // entao retornaremos nao Ok (.f. - false).
   endif
   if nTmp = NIL   // Nao veio o Tempo para Excluir?
      nTmp := 0    // Entao definimos ZERO Segundo como Padrao.
   endif

   // Vamos EXCLUIR o Arquivo.
   if !empt( cArq )   // Tem algum arquivo para Excluir?
      // Tenta APAGAR o Arquivo em ate "nTmp" segundos.
      nSec := seconds() + nTmp
      do while File( cArq )       // Enquanto EXISTIR continuaremos
         if FErase( cArq ) != 0   // a tentar EXCLUIR.
            if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
               lRet := .f.           // Entao nao consegue mesmo.
               exit                  // Saimos com o Erro de Exclusao.
            endif
         endif
      enddo
   endif

return lRet


/*
   Sintaxe: ARQ_LER(<ExpC1> <,ExpN1> <,ExpN2> <,ExpN3>)
   Funcao.: Le um Arquivo para recuperar informacoes.
              ExpC1 = Arquivo para Ler.
              ExpN1 = Tempo para Tentar LER o Arquivo. Opcional.
              ExpN2 = Posicao Inicial do Arquivo para LER. Opcional.
              ExpN2 = Posicao Final do Arquivo para LER. Opcional.
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
              nHan = Variavel "Handle DOS", do Arquivo Criado para identificacao.
              cBuf = Buffer dos Dados.
              nByt = Quantidade de bytes para Ler.
              nRef = Variavel temporaria, posicao de Referencia no arquivo.
              nSec = Tempo em Segundos (seconds) para tentativa de ACESSO ao Arquivo.
   Retorna: String com Dados do Arquivo.
   Observ.: Trata os erros de abertura e leitura.
            Se arquivo for maior que 64k exige-se que busque somente uma parte do arquivo.
            Caso contrario retorna todo o conteudo do arquivo.
*/
Function ARQ_LER( cArq, nTmp, pIni, pEnd )
   Local cRet := ""   // O retorno eh vazio por enquanto.
   Local nHan := -1   // Handle DOS. Faixa: 0...65535. (-1 eh Erro.)
   Local cBuf := ""   // Buffer de Dados vazio por enquanto.
   Local nByt := 0    // Nenhum byte ainda.
   Local nRef := 0    // Variavel temporaria usada para arrumar pIni e pEnd.

   // Formata os Dados passados.
   if cArq = NIL    // Nao veio Arquivo para LER?
      cArq := ""    // Nao vai LER nenhum Arquivo...
   endif
   if nTmp = NIL    // Nao veio o Tempo para tentar Ler?
      nTmp := 0     // Entao definimos ZERO Segundo como Padrao.
   endif
   if pIni = NIL    // Nao veio o Posicao do Arquivo para continuar a Ler?
      pIni := 0     // Entao definimos ZERO como Padrao (Inicio do Arquivo).
   endif
   if pEnd = NIL    // Nao veio o Posicao do Arquivo para finalizar a Ler?
      pEnd := 0     // Entao definimos ZERO como Padrao (Inicio do Arquivo).
   endif
   if pEnd < pIni   // Informou a Posicao Final menor que Posicao Inicial?
      // Entao sera de forma retroativa:
      // Exemplo: pIni=20 pEnd=5 => sera => pIni=15 e pEnd=20
      nRef := pIni          // Armazenamos temporariamente a referencia.
      pIni := pIni - pEnd   // Posicao Inicial sera retroativa.
      pEnd := nRef          // Posicao Final sera ate a posicao de regressao.
      nRef := NIL           // Essa variavel nao sera mais utilizada.
   endif

   // Vamos LER o Arquivo.
   if !empt( cArq )   // Tem algum arquivo para Ler?
      // Tenta Abrir/Ler o Arquivo em ate "nTmp" segundos.
      nSec := seconds() + nTmp
      do while .t.   // LOOP Tentativa de Abertura do Arquivo.
         if File( cArq )   // Achou o Arquivo?
            nByt := ARQ_TAM( cArq )   // Qual o tamanho deste Arquivo em bytes?
            nHan := FOpen( cArq )     // Entao vamos abri-lo.
            if FError() = 0   // Nao deu nenhum ERRO. Entao foi Aberto o Arquivo.
               // Vamos Verificar o que podemos LER no Arquivo.
               if pEnd > 0   // Informou uma posicao Final?
                  // Posicao Inicial - Posicao Final.
                  nByt := (pIni - pEnd)
               else
                  // Tamanho do Arquivo menos a Posicao Inicial.
                  nByt := (nByt - pIni)
               endif
               // Obs.: Tamanho maximo da Cadeia de Caracteres eh 64 KBytes.
               //       Entao "cRet" so pode ter um tamanho de 65535 caracteres.
               if (nByt + Len("OK: ")) > 65535    // Eh maior que 64 Kbytes? 
                  nByt := (65535 - Len("OK: "))   // Ent„o vamos Ler so este tamanho maximo.
               endif
               // Vamos posicionar o Ponteiro no Arquivo.
               ARQ_INI( nHan )   // Posiciona no Inicio do Arquivo.
               FSeek( nHan, pIni, 1 )   // Posiciona Ponteiro no Arquivo.
               // Vamos Ler os Dados do arquivo agora.
               do while .t.   // LOOP Tentativa de Leitura do Arquivo.
                  cBuf := space( nByt )   // Preparamos o tamanho do Buffer para receber os Dados Lidos.
                  if FRead( nHan, @cBuf, nByt ) = nByt   // Deu tudo Certo?
                     cRet := cBuf   // Armazenamos os Dados lidos.
                     exit           // Entao Ok... Saimos do LOOP de Tentativa.
                  else
                     if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
                        cRet := "ERRO: Nao foi possivel LER o arquivo."
                        exit   // Saimos... nao vamos tentar mais.
                     endif
                  endif
               enddo   // Fim do LOOP Tentativa de Leitura do Arquivo.
               if FError() = 0      // Conseguiu Ler Tudo?
                  FClose( nHan )    // Fechamos o Arquivo.
                  if FError() = 0   // Conseguiu Fechar? (e escrever os buffers do Disco)
                     exit           // Entao Ok... Saimos.
                  endif   // Se nao conseguir, repetimos a operacao
               endif      // de Abertura/Leitura do Arquivo novamente.
            else   // Deu erro? Nao conseguiu ABRIR?
               if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
                  cRet := "ERRO: Nao e possivel Abrir o Arquivo."
                  exit   // Saimos... nao vamos tentar mais.
               endif
            endif
         else   // Nao conseguiu ACHAR?
            if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
               cRet := "ERRO: Arquivo nao Localizado."
               exit   // Saimos... nao vamos tentar mais.
            endif
         endif
      enddo   // Fim do LOOP Tentativa de Abertura do Arquivo.
   endif

   // Formatando a Resposta se "OK:" para validacao posterior, ou seja,
   // tem que retornar algo para informar se "OK" ou "ERRO" na mensagem.
   if substr(cRet, 1, 5) != 'ERRO:'
      cRet := 'OK: '+cRet   // Retorna "OK: " mais o dado da Leitura.
   endif

return cRet


/*
   Sintaxe: ARQ_PES(<ExpC1> <,ExpC2> <,ExpC3> <,ExpN1>)
   Funcao.: Pesquisa Dados em um Arquivo para recuperar/trocar informacoes.
              ExpC1 = Arquivo para Ler.
              ExpC2 = Variavel a Localizar.
              ExpC3 = Variavel para Trocar. Opcional.
              ExpN1 = Tempo para Tentar LER o Arquivo.
   Local..: Variaveis locais utilizadas.
              aRet = Vetor/Array de Retorno da Quantidade/Posicao de Ocorrencias no Arquivo.
              nHan = Variavel "Handle DOS", do Arquivo Criado para identificacao.
              cBuf = Buffer dos Dados.
              nByt = Quantidade de bytes para Ler.
              cByt = Byte de Pesquisa.
              nQtd = Quantidade de bytes Lidos.
              nSec = Tempo em Segundos (seconds) para tentativa de ACESSO ao Arquivo.
   Retorna: Vetor com as posicoes das Ocorrencias encontradas.
   Observ.: Pesquisa String dentro do Arquivo. Faz a pesquisa em todo o Arquivo.
            Opcionalmente Troca a String por uma outra String no Arquivo.
*/
Function ARQ_PES( cArq, cPes, cTro, nTmp )
   Local aRet := {}   // Array com as Ocorrencias Encontradas. Vazio por enquanto.
   Local nHan := -1   // Handle DOS. Faixa: 0...65535. (-1 eh Erro.)
   Local cBuf := ""   // Buffer de Dados vazio por enquanto.
   Local nTam := 0    // Tamanho em Bytes do Arquivo.
   Local nByt := 0    // Quantidade de Bytes Lidos do Arquivo.

   // Formata os Dados passados.
   if cArq = NIL    // Nao veio Arquivo para LER?
      cArq := ""    // Nao vai LER nenhum Arquivo...
   endif
   if nTmp = NIL    // Nao veio o Tempo para tentar Ler?
      nTmp := 0     // Entao definimos ZERO Segundo como Padrao.
   endif
   if cPes = NIL    // Nao veio o que Pesquisar no Arquivo?
      cPes := ""    // Entao nao vai Pesquisar nada.
   endif
   if cTro = NIL    // Nao veio o que Trocar no Arquivo?
      cTro := ""    // Entao nao vai Trocar nada.
   endif

   // Vamos LER o Arquivo.
   if !empt( cArq )   // Tem algum arquivo para Ler?
      // Tenta Abrir/Ler o Arquivo em ate "nTmp" segundos.
      nSec := seconds() + nTmp
      do while .t.   // LOOP Tentativa de Abertura do Arquivo.
         if File( cArq )   // Achou o Arquivo?
            nTam := ARQ_TAM( cArq )   // Qual o tamanho deste Arquivo em bytes?
            nHan := FOpen( cArq )     // Entao vamos abri-lo.
            if FError() = 0   // Nao deu nenhum ERRO. Entao foi Aberto o Arquivo.
               ARQ_INI( nHan )   // Posiciona no Inicio do Arquivo.

//-------------
               *** TERMINAR DE IMPLEMENTAR...

               // Vamos Ler os Dados do arquivo agora.
               do while .t.   // LOOP Tentativa de Leitura do Arquivo.

                  if nByt >= nTam - len(cPes) + 1
                     Fclose( nHan )
                     exit
                  endif

                  cBuf := space( 1 )   // Preparamos o tamanho do Buffer para receber os Dados Lidos.
                  if FRead( nHan, @cBuf, 1 ) = 1   // Deu tudo Certo?
                     // Riberto
                     if cBuf = subs( cPes, 1, 1 )   // Achou o 1o. Caractere?
                        cBuf := len( cPes )   // Preparamos o tamanho do Buffer para receber os Dados Lidos.
                        fseek( nHan, -1, 1)   // Voltamos o Ponteiro para Ler o Caracter inteiro.
                        if FRead( nHan, @cBuf, len(cPes) ) = len(cPes)   // Deu tudo Certo?
                           if cBuf = cPes   // Eh a expressao que procuramos?
                              // Adicionamos no Vetor a Posicao Inicial do Item Encontrado.
                              aadd( aRet, (ARQ_POS(nHan) - len(cPes) ))
                              if cTro <> NIL   // Informou expressao de Troca?
                                 fseek( nHan, -(len(cPes)), 1)     // Voltamos o Ponteiro.
                                 fwrite( nHan, cTro, len(cTro) )   // Trocamos a String.
                                 * if FError() = 0      // Conseguiu Escrever?
                                 * endif
                              endif
                           endif
                        endif
                     endif
                     * fseek( nHan, 1, -1)   //
                     nByt++
                  else
                  endif
               enddo   // Fim do LOOP Tentativa de Leitura do Arquivo.
               if FError() = 0      // Conseguiu Ler Tudo?
                  FClose( nHan )    // Fechamos o Arquivo.
                  if FError() = 0   // Conseguiu Fechar? (e escrever os buffers do Disco)
                     exit           // Entao Ok... Saimos.
                  endif   // Se nao conseguir, repetimos a operacao
               endif      // de Abertura/Leitura do Arquivo novamente.

//-------------

            else   // Deu erro? Nao conseguiu ABRIR?
               if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
                  cRet := "ERRO: Nao e possivel Abrir o Arquivo."
                  exit   // Saimos... nao vamos tentar mais.
               endif
            endif
         else   // Nao conseguiu ACHAR?
            if (seconds() > nSec )   // Ja passou o Tempo de Tentativa?
               exit   // Saimos... nao vamos tentar mais.
            endif
         endif
      enddo   // Fim do LOOP Tentativa de Abertura do Arquivo.
   endif

return aRet

* \\ Final de ACBr_ARQ.PRG
