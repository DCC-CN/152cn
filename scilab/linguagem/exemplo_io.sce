//Simple SCILAB Input and Output
//==============================
//Ref: http://www.cs.laurentian.ca/jdompierre/html/COSC2831E_W2008/scilab/08_IO.txt

// limpar a janela de comandos
clc;
// limpa as variáveis
clear;

mode(5)

// informa o diretório corrente (pwd)
printf("Diretório atual = %s\n", pwd());

// cria um diretório
[status, msg] = mkdir("teste")
// se não criar o dirtório, mostra a mensagem e aborta a execução
if status <> 1 then
    printf("%s\n", msg);
    abort;
end

// muda de diretório
if ~chdir("teste") then
    printf("Falha ao mudar de diretório...\n", msg);
    abort;
end
printf("Mudou para o diretório %s\n", pwd());

//----------------------------------------------------------------------------
// inicia um diário (histórico) de comandos e saídas
diary ('diário1.txt')

// exemplo de sistema linear
A = [1. 2. 3.; 2. 3. 1.; 3. 2. 1.];
b=[5; 4; -1.];
A
b
x1 = linsolve(A,b)
x2 = A\b
x3 = inv(A) * b
// fecha o diário
diary(0)

//----------------------------------------------------------------------------
// exemplo 1 de IO: arquivos formatados
A = [ 1 2 3 4; 5 6 7 8 ];
arq = "exemplo_io_1.txt";
unit = file('open', arq, "unknown" );
write(unit, A)
file("close", unit)

unit = file('open', arq, "unknown" );
m = read(unit, 2, 3)
disp(m);
file("close", unit)

m = read(arq, 2, 2);
disp(m);

//----------------------------------------------------------------------------
// exemplo 2 de IO: arquivos binários de variáveis
c  = "Exemplo 2 de IO";
arq = "exemplo_io_2.dat";
// salva variáveis específicas (somente com o nome do arquivo salva todas)
save(arq, 'A', 'c');
// libera variáveis específicas da memória
clear A c
// carrega todas as variáveis de um arquivo binário
load(arq)
// carrega apenas uma variável de nome 'c' do arquivo binário
load(arq, 'c')
disp(c)

//----------------------------------------------------------------------------
// exemplo 3 de IO: funções "c" like (m*)
n = 17;
m = -23;
a = -0.2;
b = 2,345e-03;
c = a + %i*b;
s = "HelloWorld";

arq = "exemplo_io_3.txt";
fd = mopen(arq, "w" );
mfprintf(fd, "n = %d\n", n);
mfprintf(fd, "m = %d\n", m);
mfprintf(fd, "a = %g\n", a);
mfprintf(fd, "a = %e\n", a);
mfprintf(fd, "a = %23.16e\n", a);
mfprintf(fd, "c = %g+i%g\n", real(c), imag(c));
mfprintf(fd, "s = %s\n", s);
mclose(fd);

printf("--------------------------------------------------\n");
// lê linhas do arquivo (via mgetl)
fd = mopen(arq, "r");
while ~meof(fd)
    printf("%s\n", mgetl(fd));
end
mclose(fd);

// lê linhas no formato específico (via mfscanf)
printf("--------------------------------------------------\n");
fd = mopen(arq, "r" );
while ~meof(fd)
   // n = número de dados lidos ou -1 se EOF for encontrado
   [n, key, value] = mfscanf(fd, "%s = %s\n");
   if n == 2 then
      printf("%s = %s\n", key, value);
   end
end
printf("\n");
mclose(fd);

// DICA: se a execução terminar (como erro ou interrupção) antes de fechar 
//       qualquer arquivo, é possível fechar todos os arquivos com
//       mclose('all')
//       Mas esse comando também irá fechar o programa em execução!

//----------------------------------------------------------------------------
// exclui todos os arquivos terminados em '.txt' do diretório corrente
mdelete("*.txt")
// exclui os '.dat'
mdelete("*.dat")
// vai para o diretório anterior 
cd ("..")
// exclui o diretório teste
rmdir ("teste")

