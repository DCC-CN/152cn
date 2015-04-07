function Pz = poli_lagrange_dp(x,y,z,Exibe)
//
//  Polinomio de Lagrange usando dispositivo pratico
//
//  parametros de entrada:
//     x: vetor contendo as abscissas,
//     y: vetor contendo as ordenadas,
//     z: valor a ser interpolado e
//     Exibe: abs(Exibe) especifica quantas casas decimais sao
//        utilizadas nos calculos, tal que:
//        Exibe > 0: resultados sao exibidos,
//        Exibe = 0: nao arredonda e exibe resultados e
//        Exibe < 0: resultados nao sao exibidos.
//
//  parametro de saida:
//     Pz: valor interpolado.
//
//  carrega funcao digitos no espaco de trabalho
//
exec('digitos.sci',0)
m = length(x);
u = ones(1,m);
x = digitos(x, Exibe);
y = digitos(y, Exibe);
G = digitos(x'*u - diag(x) + z*eye(m,m) - u'*x, Exibe);
Gd = digitos(prod(diag(G)), Exibe);
Gi = digitos(prod(G,'c'), Exibe);
if Exibe >= 0
   mprintf('\nInterpolacao via polinomios de Lagrange\n')
   mprintf('\nmatriz G')
   disp(G)
   mprintf('\nGd: produto dos elementos da diagonal de G')
   disp(Gd)
   mprintf('\nGi: produto dos elementos das linhas de G')
   disp(Gi)
end
Pz = digitos(Gd * sum(y./Gi'), Exibe);
if Exibe >= 0
   mprintf('\nz =%7.3f   P%i(z) =%10.5f\n', z, m-1, Pz)
end
endfunction

