function resp = fibonacci(n)
    if n < 0 then
        error('Number must to be positive')
    end
    if int(n) <> n then
        error('Number must to be integer')
    end
    s_menos_1 = 0;
    s_atual = 1;
    r = n;
    for repet = 1:n-1
        s_novo = s_menos_1 + s_atual;
        s_menos_1 =  s_atual;
        s_atual = s_novo;
    end
    resp = s_atual;
endfunction
