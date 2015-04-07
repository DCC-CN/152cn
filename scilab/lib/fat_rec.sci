function resp = fat_rec(n)
    if n == 1 then
        resp = 1
    else
        resp = n * fat_rec(n - 1);
    end
endfunction
