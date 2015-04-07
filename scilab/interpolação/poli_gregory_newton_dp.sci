function Pz = poli_gregory_newton_dp(x,y,z,Exibe)
//
//  Polinomio de Gregory-Newton usando dispositivo pratico
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
for i = 1:m
   Dely(i,1) = digitos(y(i), Exibe);
end
//  construcao das diferencas finitas
for k = 2:m
   for i = 1:m-k+1
      Dely(i,k) = digitos(Dely(i+1,k-1) - Dely(i,k-1), Exibe);
   end
end
if Exibe >= 0
   mprintf('\nInterpolacao via polinomios de Gregory-Newton\n')
   mprintf('\n        Tabela de diferencas finitas')
   mprintf('\n  i     x(i)      y(i) ')
   for j = 1:m-1
      mprintf('   DifFin%i', j)
   end
   mprintf('\n')
   for i = 1:m
      mprintf('%3i%10.5f', i-1, x(i))
      for j = 1:m+1-i
         mprintf('%10.5f', Dely(i,j))
      end
      mprintf('\n')
   end
end
//   avaliacao do polinomio pelo processo de Horner
u = (z - x(1)) / (x(2)-x(1));
Pz = Dely(1,m);
for i = m-1:-1:1
   Pz = digitos(Pz * (u - i + 1) / i + Dely(1,i), Exibe);
end;
if Exibe >= 0
   mprintf('\nz =%7.3f   P%i(z) =%10.5f\n', z, m-1, Pz)
end
endfunction

