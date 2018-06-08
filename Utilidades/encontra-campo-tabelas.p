output to "c:\banco.txt".

def temp-table tt-lista no-undo 
field tabela as char format "x(30)" 
field campo  as char format "x(30)".
 
for each banco._file no-lock: 

for each banco._field of banco._file where banco._field-name matches "*pesquisar*" no-lock : 

create tt-lista. 
assign tt-lista.tabela = _file._file-name 
       tt-lista.campo  = _field._field-name. 
 end.
end. 

for each tt-lista.
    
    disp tt-lista.tabela 
         tt-lista.campo. 

end.
