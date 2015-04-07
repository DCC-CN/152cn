function x = zera(x, prec)
    //
    //  zera valores menores que epsilon
    //
    x = digitos(x, prec);
    epsilon = 10^(-prec);
    for i = 1:size(x, '*')
        if abs(x(i)) < epsilon then
            x(i) = 0
        end
    end
endfunction
