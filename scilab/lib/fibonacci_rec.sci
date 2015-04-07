function resp = fibonacci_rec(n)
    if(n <= 1) then
        resp = n;
    else
        resp = fibonacci_rec(n - 1) + fibonacci_rec(n - 2);
    end
endfunction
