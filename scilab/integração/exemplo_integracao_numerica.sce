// limpar a janela de comandos
clc;
// limpa as variáveis
clear;
// suprimir mensagem de redefição de função
funcprot(0);
// carrega arquivos .sci do diretório ('.' = diretório atual)
getd('..\lib');


function exemplo1
    // define a função
    func = "y = 1 - x^2";
    deff("y = f(x)", func);
    // define o intervalo
    from = 0;
    to = 1.5;
    slices = 20;
    // gera a amostra de pontos da abscissa
    x = [from : (to - from)/(slices -1) : to];
    // calcula as ordenadas
    y = feval(x, f);
    // desenha o gráfico
    plot2d(x, y, leg = func);
    //------------------------------------------------------------------------
    // O Scilab possui várias entidades gráficas dispostas de forma hierárquica
    // veja https://help.scilab.org/docs/5.5.0/pt_BR/graphics_entities.html
    // No geral, a entidade figura é a de maior nível na hierarquia
    // Uma figura pode conter diversos eixos (normalmente, utiliza-se apenas um)
    //------------------------------------------------------------------------
    // Obtém o controle (handle) do eixo da figura (entidade gráfica axes)
    // Um eixo representa o desenho de um ou mais linhas em escala comum
    // Por exemplo, a função de plotagem trabalha em nível de eixo
    // veja https://help.scilab.org/docs/5.5.0/pt_BR/axes_properties.html
    fig_axes = gca(); 
    fig_axes.x_location = "origin"; // define a posição da linha do eixo x
    fig_axes.y_location = "origin"; // define a posição da linha do eixo y 
    f_axis = fig_axes.children(1); // Obtém o primeiro eixo do controle de eixos
    //------------------------------------------------------------------------
    // obtém o controle de desenho da linha (entidade gráfica polyline) 
    // veja https://help.scilab.org/docs/5.5.0/pt_BR/polyline_properties.html
    // Uma linha (definida pela amostra de ponsots x, y) é subelemto de um eixo
    f_polyline = f_axis.children(1);       // linha da função f(x)
    f_polyline.thickness = 3;              // ajusta a largura da linha
    f_polyline.foreground = color('blue'); // ajusta a cor da linha
    //------------------------------------------------------------------------
    // obtém o controle de desenho da legenda do eixo (entidade gráfica)
    // veja https://help.scilab.org/docs/5.5.0/pt_BR/legend_properties.html
    f_leg = fig_axes.children(2);
    f_leg.line_mode = "on";
    f_leg.legend_location = "in_lower_right";
    //------------------------------------------------------------------------
    // obtém o controle de desenho da linha do polígono
    // faz o cálculo numérico da integral por interpolação trapezoidal
    fT = inttrap(x, y);
    // faz o cálculo numérico pela função intsplin (interpolação spline)
    fS = intsplin(x, y)
    // faz o cálculo numérico da integral por quadratura
    // Nota: usa a função intg, veja código fonte com fun2string(integrate)
    fQ = integrate('f','x', from, to);
    // Nota: a função intg (assim como a integrate) gera a amostragem de pontos para a quadratura
    // Not2: Elaborada em FORTRAN (http://fossies.org/dox/scilab-5.5.0-src/intg_8f_source.html)
    [fI, intg_err] = intg(from, to, f);
    intsplin
    // faz a solução analítica
    Rf = (to - (to^3)/3) - (from - (from^3)/3);
    // exibe a solução
    printf("\nIntegral de %g à %g da função f(x) = 1 - x^2\n", from, to);
    printf("Solução algébrica     = %f \n", Rf);
    printf("Solução por inttrap   = %f (erro %f)\n", fT, abs(Rf - fT));
    printf("Solução por intsplin  = %f (erro %f)\n", fS, abs(Rf - fS));
    printf("Solução por integrate = %f (erro %f)\n", fQ, abs(Rf - fQ));
    printf("Solução por intg      = %f (intg_err = %g) (erro %f)\n", fI, intg_err, abs(Rf - fI));
    // salva imagem do desenho usando xs2* no formato jpg
    // gcf() retorna o controle (handle) da janela atual
    xs2png(gcf(), 'exemplo_in_1.png');
    printf("\nVerifique o arquivo exemplo_in_1.png com a imagem da função.\n");
endfunction

//------------------------------------------------------------
function exemplo2

    // define a função
    deff("y = f(x)", "y = 1 - x^2");
    // define o intervalo
    from = 0;
    to = 1.5;
    slices = 20;
    // faz a solução analítica
    Rf = (to - (to^3)/3) - (from - (from^3)/3);

    fL = Sumint('L', from, to, slices, f);
    fM = Sumint('M', from, to, slices, f);
    fR = Sumint('R', from, to, slices, f);
    fT = Sumint('T', from, to, slices, f);
    
    printf("\nIntegral de %g à %g da função f(x) = 1 - x^2\n", from, to);
    printf("Solução algébrica   = %f \n", Rf);
    printf("Solução numérica (aprox. pela esquerda) = %f (erro %f)\n", fL, abs(Rf - fL));
    printf("Solução numérica (aprox. pelo centro)   = %f (erro %f)\n", fM, abs(Rf - fM));
    printf("Solução numérica (aprox. pela direita)  = %f (erro %f)\n", fR, abs(Rf - fR));
    printf("Solução numérica (aprox. trapezoidal)   = %f (erro %f)\n", fT, abs(Rf - fT));
endfunction

//------------------------------------------------------------
function exemplo3
    // define a função
    deff("y = f(x)", "y = 1 - x^2");
    // define o intervalo
    from = 0;
    to = 1.5;
    // faz a solução analítica
    Rf = (to - (to^3)/3) - (from - (from^3)/3);
    // aumento da precisão com aumento da amostra de pontos (redução da distância)
    slices_seq = [ 10, 100, 1000, 10000, 100000];
    resp_seq = [];
    
    printf("Solução algébrica  = %f \n", Rf);
    for i = 1:size(slices_seq, "*")
        slices = slices_seq(i);
        resp = Sumint('T', from, to, slices, f);
        printf("Amostra com %6d pontos = %2.12g (erro = %g)\n", slices, resp, Rf - resp);
    end
endfunction

//------------------------------------------------------------
function exemplo4
    from = 0;
    to = %pi;
    slices = 40;
    deff("y = f(x)", "y = sin(x) + sin(2*x)");
    Rg = -cos(to)-(1/2)*(cos(2*to))-(-cos(from) - (1/2)*cos(2*from));
    
    gL = Sumint('L', from, to, slices, f);
    gM = Sumint('M', from, to, slices, f);
    gR = Sumint('R', from, to, slices, f);
    gT = Sumint('T', from, to, slices, f);
    
    printf("\nIntegral de %g à %g da função f(x) = sin(x) + sin(2*x)\n", from, to);
    printf("Solução algébrica  = %f \n", Rg);
    printf("Solução numérica (aprox. pela esquerda) = %f (erro %f)\n", gL, abs(Rg - gL));
    printf("Solução numérica (aprox. pelo centro)   = %f (erro %f)\n", gM, abs(Rg - gM));
    printf("Solução numérica (aprox. pela direita)  = %f (erro %f)\n", gR, abs(Rg - gR));
    printf("Solução numérica (aprox. trapezoidal)   = %f (erro %f)\n", gT, abs(Rg - gT));
endfunction

//----------------------------------------------------------------
// Exemplo de descontinuidade 1 (não-convergencia)
function exemplo5
    from = -1;
    to = 1;
    slices = 50;
    
    function y = f(x)
        if x == 0 then
            y = %inf;
        else
            y = 1/(x);
        end
    endfunction
    
    Rt = log(to) - log(from);
    
    tL = Sumint('L', from, to, slices, f);
    tM = Sumint('M', from, to, slices, f);
    tR = Sumint('R', from, to, slices, f);
    tT = Sumint('T', from, to, slices, f);
    
    printf("\nIntegral de %g à %g da função t(x) = 1/x\n", from, to);
    printf("Solução algébrica  = %f \n", Rt);
    printf("Solução numérica (aprox. pela esquerda) = %f (erro %f)\n", tL, abs(Rt - tL));
    printf("Solução numérica (aprox. pelo centro)   = %f (erro %f)\n", tM, abs(Rt - tM));
    printf("Solução numérica (aprox. pela direita)  = %f (erro %f)\n", tR, abs(Rt - tR));
    printf("Solução numérica (aprox. trapezoidal)   = %f (erro %f)\n", tT, abs(Rt - tT));
endfunction    

//------------------------------------------------------------
// Exemplo de descontinuidade 2 (não-convergencia) 
function exemplo6
    from = -0.1;
    to = 0.1;
    slices = 50;
    
    function y = t(x)
        if x == 0 then
            y = %inf;
        else
            y = 1/(x^2);
        end
    endfunction
    
    Rt = (-inv(to)) - (-inv(from));
    
    tL = Sumint('L', from, to, slices, t);
    tM = Sumint('M', from, to, slices, t);
    tR = Sumint('R', from, to, slices, t);
    tT = Sumint('T', from, to, slices, t);
    
    printf("\nIntegral de %g à %g da função f(x) = 1/(x^2)\n", from, to);
    printf("Solução algébrica  = %f \n", Rt);
    printf("Solução numérica (aprox. pela esquerda) = %f (erro %f)\n", tL, abs(Rt - tL));
    printf("Solução numérica (aprox. pelo centro)   = %f (erro %f)\n", tM, abs(Rt - tM));
    printf("Solução numérica (aprox. pela direita)  = %f (erro %f)\n", tR, abs(Rt - tR));
    printf("Solução numérica (aprox. trapezoidal)   = %f (erro %f)\n", tT, abs(Rt - tT));
endfunction

//
// BUG conhecido: 
// Fechar a janela de escolha (com o botão X @right_top)
// mantém o programa em estado de espera, mesmo sem janela visível.
//

mode(4) // apresenta a saída de resultados 
escolha = 1;
opcoes = ["Múltiplas soluções, com recursos do Scilab, da função f(x) = 1 - x^2";
          "Múltiplas soluções para f(x) = 1 - x^2";
          "Aumento da precisão com o aumento da amostragem de pontos";
          "Múltiplas soluções para f(x) = sin(x) + sin(2*x)";
          "Múltiplas soluções para f(x) = 1/x [!]";
          "Múltiplas soluções para f(x) = 1/(x^2) [!]"];
while %T
    escolha = x_choose_modeless(opcoes,['Exemplos de integração numérica';
                                        'Escolha uma opção abaixo:']);
    for x = winsid()
        xdel(x);
    end
    clc
    if escolha < 1 | escolha > 6 then
        abort;
    end
    printf("\n-- Exemplo %d de Integração Numérica --\n", escolha);
    execstr('exemplo'+string(escolha))
end

