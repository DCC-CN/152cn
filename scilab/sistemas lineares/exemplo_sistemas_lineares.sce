//------------------------------------------
mode(5)  // modo de execução com saída de comandos e resultados

// limpa a tela de comandos
clc  
// libera a memória de todas as variáveis 
// incluindo funções definidas dinamicamente
clear 

//------------------------------------------
// carga de todos os programas sci de um diretório
getd('../lib')

//------------------------------------------
// exemplo 1 de sistema linerar
coeficientes = [1,  6, 2,  4;
                3, 19, 4,  15;
                1,  4, 8, -12;
                5, 33, 9,   3]
          
termos_independentes = [ 8; 25; 18; 72 ]

solucao = coeficientes \ termos_independentes

residuo = termos_independentes - coeficientes * solucao

//------------------------------------------
// exemplo 2 de sistema linerar

//-------------------
// 2*x_1 + 3*x_2 = 8
//   x_1 -   x_2 = -1
A = [2, 3; 1, -1]
b = [8; -1]
d = det(A)
// formas de solução de sistema linear 
// ref: http://www.infoclearinghouse.com/files/scilab/scilab5a.pdf
// Resolve a equação Ax + b = 0, ou seja, Ax = -b, supondo c = -b:
c = -b
x = linsolve(A, c)
r = b - A*x   // verificação da solução (resíduo)

// Resolve a a equação  Ax = b => A^(-1)Ax = A^(-1) * b => x = A^(-1) * b
x = inv(A) * b
r = b - A*x   // verificação da solução (resíduo)

// Resolve a equação Ax = b 
// Nota: equivalente à solução anterior, com notação simplificada
// Ref: http://help.scilab.org/docs/5.3.3/pt_BR/backslash.html
x = A\b
r = b - A*x   // verificação da solução (resíduo)

// Resolve a equação xb = A na forma x = A / b
// Nota: A/b = (b'\A')' (solução equivalente à anterior)
// Ref: http://help.scilab.org/docs/5.3.3/pt_BR/slash.html
x = (b'/A')'
r = b - A*x   // verificação da solução (resíduo)

//-------------------
// 2*x_1 - 2*x_2 = -2
//   x_1 + 4*x_2 = 9
A2 = [2 -2;...
      1 4];
b2 = [-2; 9];
// solução por função definida pelo usuário
x2 = solucao_sistema_linear(A2, b2)
r2 = b2 - A2*x2   // verificação da solução (resíduo)
// verificação da solução
if find((A2*x2 == b2) == %F) then
    disp("Erro");
else
    disp("OK");
end
// verificação de equivalência de sistemas:
// A e A2 possuem uma solução equivalente?
if A2*x == A*x2 then
    disp("A e A2 são equivalentes");
else
    disp("A e A2 não são equivalentes");
end

//---------------------
// -- Sistema singular
// 12*x_1 + 3*x_2 = 15
//  4*x_1 +   x_2 = 5
A3 = [12 3;...
      4 1];
b3 = [15; 5];
// Tentativa de solução de sistema singular
x3 = solucao_sistema_linear(A3, b3)

//------------------------------------------------
// exemplo 3 de sistema linerar: matrizes esparsas
// Uma matrizes é considerada esparsas quando
// a "maioria" de seus elementos são nulos (zero).
// Sua representação interna (estrutura de dados) pode ter
// espaço minimizado (a custa de aumento no tempo de acesso)

A = sparse( [ 2  3  0  0  0;
              3  0  4  0  6; 
              0 -1 -3  2  0; 
              0  0  1  0  0; 
              0  4  2  0  1] );
b = [8 ; 45; -3; 3; 19];

// Função umfpack é otimizada para matrizes esparsas "grandes"
// e funciona com sistemas lineares complexos (com números complexos)
// Ref: https://help.scilab.org/docs/5.5.0/pt_BR/umfpack.html

// verifica unicidade 

// Exemplo de solução de sistema de matriz espaça #1
x = umfpack(A,"\",b)
r = b - A*x   // verificação da solução (resíduo)

// Exemplo de solução de sistema de matriz espaça #2
x = linsolve(A, -b, x)
r = b - A*x   // verificação da solução (resíduo)

// Exemplo de solução de sistema de matriz espaça #3
x = inv(A) * b
r = b - A*x   // verificação da solução (resíduo)

// Exemplo de solução de sistema de matriz espaça #4
x = A\b
r = b - A*x   // verificação da solução (resíduo)

// Exemplo de solução de sistema de matriz espaça #5
x = (b'/A')'
r = b - A*x   // verificação da solução (resíduo)

//------------------------------------------------
// exemplo 4 de sistema linerar: solução simbólica
// Ref: http://help.scilab.org/docs/5.4.1/pt_BR/solve.html

A=['1','a';'4','2'];   //Upper triangular 
b=['x';'y'];

w=solve(A,b)

a=1;
x=2;
y=5;
s1 = evstr(w)
s2 = inv([1,1;0,2])*[2;5]
if s1 == s2 then
    printf("OK")
else
    printf("Erro")
end

//-------------------------------------------------
// exemplo 5: Decomposição LU e pivotação parcial
A = [2 4 6; 3 -2 1; 4 2 -1]
b = [14; -3; -4]
[L, U, P] = lu(A)
P*A == L*U
y = substSuces(L, (P*b))  // Ly = Pb => y = L\(P*b)
x = substRetro(U, y)     // Ux = y  => x = U\y
r = b - A*x   // verificação da solução (resíduo)

//-------------------------------------------------
// exemplo 6: Decomposição de Cholesky
// Matriz deve ser: 1) simétrica, A(i,j) = A(j,i)
//                  2) positiva definida, x'Ax > 0
A = [25 15 -5; 15 18 0; -5 0 11]
b = [5; -3; -4]

if A == A' then
    printf("Matriz simétrica")
end

// A função chol analisa as pré-condições para decomposição
Lt = chol(A)
L = Lt'
y = substSuces(L, b)   // Ly = b  => y = L\b
x = substRetro(Lt, y)  // L'x = y => x = L'\y
r = b - A*x   // verificação da solução (resíduo)

//-------------------------------------------------
// exemplo 7: Análise de erro na solução de sistemas
// Matriz quase singular
// Verificar a singularidade pelo determinante não é boa prática,
// pois os coeficientes do sistemas podem ser simplesmente pequenos 

A = [1 .99; .99 .98]
b = [1.99; 1.97]
det(A)
A\b

b2 = [1.99; 1.98]
A\b2


A = [1 .99; .99 .99]
b = [1.99; 1.97]
det(A)
A\b
