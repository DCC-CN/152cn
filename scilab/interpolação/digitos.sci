function y = digitos(x,Exibe)
//
//  arredonda valor de x com numero de casas decimais dadas por Exibe
//
if Exibe ~= 0
   y = round(x * 10^abs(Exibe)) * 10^(-abs(Exibe));
else
   y = x;
end
endfunction

