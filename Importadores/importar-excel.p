
/* HANDLES E VARIAVEIS NECESSÁRIO PARA PROCESSAMENTO DO XLSX */
def var chExcelApplication  as COM-HANDLE.
def var chWorkbook          as COM-HANDLE.
def var chWorksheet         as COM-HANDLE.
def var chChart             as COM-HANDLE.
def var chWorksheetRange    as COM-HANDLE.
def var cRange              as char.


def var i-linha             as int. /* CONTADOR DE LINHAS */

def var a as char. 
def var b as char. 

create "Excel.Application" chExcelApplication. /* ABRE EXCEL.EXE*/

chWorkbook  = chExcelApplication:Workbooks:open("c:\arquivo.xlsx"). /*ABRE O ARQUIVO .XLSX */
chWorksheet = chExcelApplication:sheets:item(1). /* SETA A ABA DO EXCEL */

assign i-linha = 1. /* DEFINE EM QUAL LINHA COMEÇA A LEITURA */ 

repeat while chWorksheet:range("A" + string(i-linha)):value <> ?:

assign a  = chWorksheet:range("A" + string(i-linha)):value.
assign b  = chWorksheet:range("B" + string(i-linha)):value.


assign i-linha = i-linha + 1.

end. 

/*ELIMINA O PROCESSO EXCEL.EXE */
release object chExcelApplication.
release object chWorkbook.
release object chWorksheet.     


