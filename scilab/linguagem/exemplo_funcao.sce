// https://help.scilab.org/docs/5.5.0/en_US/isdef.html
clc;
clear;
mode(5)
// define algumas variáveis
A = 1; B = 2; C = 3; D = 4;
// isdef verifica se as variáveis da matriz estão definidas
disp(isdef(['A', 'B'; 'C', 'D']));
// exclui variáveis específicas
clear A B C D;
// verifica novamente se as variáveis estão definidas
disp(isdef(['A', 'B', 'C', 'D']));

function level1()
  function level2()
    disp(isdef(["a", "b"], "a"));
    disp(isdef(["a", "b"], "l"));
    disp(isdef(["a", "b"], "n"));
  endfunction
  level2()
endfunction

function go()
  a = 1;
  level1()
endfunction

go()
