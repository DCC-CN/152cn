function [xr]= fround(x,n)
//  arredondamento de x em n casas decimais
//
    n = abs(int(n));
    xr=round(x*10^n)/10^n;
endfunction
