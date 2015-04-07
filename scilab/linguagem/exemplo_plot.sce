// limpar a janela de comandos
clc;
// limpa as variáveis
clear;

    // define uma função
    func = "y = x^4 - 5*x^2 + 4";
    deff("y = f(x)", func)
    // gera a amostra de pontos da abscissa
    x = [-3 : 0.001 : 3];
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
    f_leg.legend_location = "in_upper_right";
    //------------------------------------------------------------------------
    // salva imagem do desenho usando xs2* no formato jpg
    // gcf() retorna o controle (handle) da janela atual
    xs2png(gcf(), 'exemplo_plot_1.png');
