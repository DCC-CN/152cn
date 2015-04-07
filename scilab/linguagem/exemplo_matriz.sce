//------------------------------------------
// mode(7)  // modo de execução com pausa
// mode(5)  // modo de execução com saída de resultados
mode(5)  // modo de execução com saída de comandos e resultados

// suprimir menagem de redefição de função
funcprot(0);

// limpa a tela de comandos
clc  
// libera a memória de todas as variáveis 
// incluindo funções definidas dinamicamente
clear 

// ----------------------------------------------------------------------------
// Exemplos de operações básicas
// NOTA: As operações matriciais escalares dependem do tipo de dado usado
//       Porém, é pode ser necessário deixar explícito 
//       se a operação é matricial ou é escalar, como as multiplicações.
//       Na sintaxe do Scilab, o caractere de "." (ponto)
//       antes do sinal da operação aritmética, 
//       especifica que a operação é escalar e não matricial.
Matriz = [ 1 0 2 1; 1 1 1 2; -1 -1 0 -2; 2 0 4 3 ]

transposta = Matriz'
matriz_inversa = inv(Matriz)
matriz_identidade = Matriz * matriz_inversa

soma = 2 + Matriz
soma_matricial = Matriz + matriz_inversa

multipl_por_escalar = 2 * Matriz
multipl_matricial = Matriz * matriz_inversa
multipl_escalar = Matriz .* matriz_inversa

exponencial_matricial = Matriz ^ 3
exponencial_escalar = Matriz .^ 3

matriz_identidade = eye(4,4)
matriz_de_zerosZ = zeros(4,4)
matriz_de_uns = ones(4,4)
determinante = det(Matriz)
maximo = max(Matriz)
minimo = min(Matriz)
soma = sum(Matriz)
norma = norm(Matriz)

// ----------------------------------------------------------------------------
// EXEMPLOS DE ACESSO E SELEÇÃO

// elemento específico
Matriz(1,1) = 40
// Linha 1
Matriz(1,:)
// Coluna 1
Matriz(:,1)
// linhas 2 até 4, coluna 3
Matriz(2:4, 3)
// transposta da seleção
Matriz(2:4, 3)'
// Troca (swap) linhas 1 e 2
linha = Matriz(2,:)
Matriz(2,:) = Matriz(1,:)
Matriz(1,:) = linha
clear linha // libera a variável temporária
// Troca (swap) colunas 4 e 2
coluna = Matriz(:, 4)
Matriz(:, 4) = Matriz(:, 1)
Matriz(:, 1) = coluna
clear coluna // libera a variável temporária

// modificando valores
Matriz(2, 2) = %pi
Matriz(3, 2:3) = [%e, -10]

// Atribuição com redimensionamento
Matriz(2:3, 4:5) = eye(2,2)

// ACESSOS SEQUENCIAIS
m = [ 1:4; 5:8; 9:12; 13:16]

// quinto elemento (obs: a matriz é 4x4)
m(5)
// último elemento
m($)
// do quinto ao último elemento
m(5:$)
// ante-penúltimo ao penúltimos elemento
m($-2:$-1)

// linhas pares
m(2:2:$, :)

// colunas pares
m(:, 2:2:$)

// linhas e colunas ímpares
m(1:2:$, 1:2:$)

// Exemplos de funções de verificações relacionadas à matrizes
ismatrix(2)
ismatrix(Matriz)
issquare(Matriz)
isrow(Matriz(1,:))
iscolumn(Matriz(1,:))
isscalar(Matriz)
isscalar(%e)
isempty(zeros(4,4))
isempty(zeros(0,0))
exists("nao_existe")
exists("soma")

// "pause" para a execução e retorna para o prompt de comandos
// até o comando "resume" ou "return" ser executado
// o comando "abort" encerra o programa
// pause;

// ----------------------------------------------------------------------------
// Exemplos de matrizes aleatória 
M_rand1 = (-100*rand()* rand(4,4))
M_rand2 = abs(-100*rand()* rand(4,4))
M_rand3 = int(100*rand()* rand(4,4))

//------------------------------------------
// Exemplo de função com matrizes
function [mul, mul2, add, sub] = many_rets(a, b)
    mul  = a * b;
    mul2 = a .* b;
    add  = a + b;
    sub  = a - b;
endfunction

[m1, m2, a, s] = many_rets(20,8)
[m1, m2, a, s] = many_rets(M_rand1, M_rand2)
