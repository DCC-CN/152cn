function Sinal = troca_sinal(Pivot)
    //
    n = length(Pivot); Sinal = 1;
    for i = 1:n-1
        [t, indice] = find(Pivot == i)
        if indice ~= i then
            t = Pivot(i), Pivot(i) = Pivot(indice), Pivot(indice) = t
            Sinal = -Sinal
        end
    end
endfunction

