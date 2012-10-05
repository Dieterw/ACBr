1. Crie o arquivo .def utilizando o utilitário DUMPBIN

O arquivo .DEF deverá conter o cabeçalho EXPORTS, seguido dos nomes das funções
Ex.:
 EXPORTS
 BAL_Ativar
 BAL_Create
 BAL_Desativar
 etc ...

2. Crie a LIB utilizando o utilitário LIB /DEF:<deffile.def> /OUT:<libfile.lib>

Ex.: LIB /DEF:ACBr32.def /OUT:ACBr32.lib