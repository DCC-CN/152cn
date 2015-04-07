function y = inv_err(x)
    try
        y = 1/x;
    catch
        y = %inf;
    end
endfunction
