function u = TrianguloFEM(divisiones, L)
  % Parámetros del problema
  r = L / 6;  % radio del obstáculo
  centro = [L/2, L/2];  % Coordenadas x e y del centro de la malla de dimensiones L*L
  dx = L / (divisiones - 1);  % Distancia de largo que va a tener el triangulo ti con el tj
  dy = L / (divisiones - 1);  % Distancia de altura que va a tener el triangulo ti con el tj
  N = divisiones^2;  % cantidad de nodos

  TablaNodo = zeros(divisiones^2,3); % Tabla de nodos que utilizaremos donde esta cada nodo que exista en la malla
  % Cargar tabla de nodos
  acum = 0;
  acum2 = 0;
  for fila = [1:divisiones^2]
    TablaNodo(fila,3) = acum2 * dy;
    acum2 = acum2 + 1;
    TablaNodo(fila,1) = fila;

    TablaNodo(fila,2) = acum * dx;
    if mod(fila,divisiones) == 0
      acum = acum + 1;
      acum2 = 0;
    endif;
   endfor;
   % --------------------
    [n,m] = size(TablaNodo); % Obtenemos las dimenciones de TablaNodo
     TablaElemento = zeros(2*(divisiones-1)^2,3); % Tabla que tendra todos los triangulos esten en TODA LA MALLA
     % elementos sera parecida a TablaElemento pero tendra los triangulos que no interactuen con el obstaculo

   % Hacemos tabla de elementos (triangulos)
   acum = 1;
   %acum2 = 1;
   for col = [1:n-divisiones]
    %for fila = [1:m]

    if (mod(TablaNodo(col,1), divisiones) != 0)
      % ----- Guardamos los puntos que se usaran para posteriormente ir guardando los triangulos -----
      p1 = TablaNodo(col,1);
      p2 = TablaNodo(col+divisiones,1);
      p3 = TablaNodo(col+divisiones+1,1);
      p4 = TablaNodo(col+1,1);
      % ---------------------------------------------
      % ----- Guardad los triangulos superiores -----
      if !TrianguloDentroCirculo(p1,p2,p3,TablaNodo,centro,r) % Verificamos que los puntos del triangulo no esten dentro o en el borde del circulo
        TablaElemento(acum,1) = acum;
        TablaElemento(acum,2) = p1;  % TablaNodo(col,1);
        TablaElemento(acum,3) = p2;  % TablaNodo(col+divisiones,1);
        TablaElemento(acum,4) = p3;  % TablaNodo(col+divisiones+1,1);
        acum = acum + 1;
      endif
     % TablaElemento(acum,1) = acum;
      %TablaElemento(acum,2) = p1; % TablaNodo(col,1);
      %TablaElemento(acum,3) = p2; % TablaNodo(col+divisiones,1);
      %TablaElemento(acum,4) = p3; % TablaNodo(col+divisiones+1,1);
      %acum = acum +1;
      % ---------------------------------------------
      % ----- Guardad los triangulos superiores -----
      if !TrianguloDentroCirculo(p1,p4,p3,TablaNodo,centro,r) % Verificamos que los puntos del triangulo no esten dentro o en el borde del circulo
        TablaElemento(acum,1) = acum;
        TablaElemento(acum,2) = p1;  % TablaNodo(col,1);
        TablaElemento(acum, 3) = p4; % TablaNodo(col+1,1);
        TablaElemento(acum, 4) = p3; % TablaNodo(col+divisiones+1,1);
        acum = acum + 1;
      endif
      %TablaElemento(acum,1) = acum;
      %TablaElemento(acum,2) = p1; % TablaNodo(col,1);
      %TablaElemento(acum,3) = p4; % TablaNodo(col+1,1);
     % TablaElemento(acum,4) = p3; % TablaNodo(col+divisiones+1,1);
    %  acum = acum +1;
      % ---------------------------------------------
      endif
   endfor
   % elementos = TablaElemento;
   tamTablaElemento = acum -1 ;
   %tamElementos = acum2 - 1

  % Inicializamos variables del sistema A*u = b para posteriormente despejar u
  A = zeros(N, N);  % matriz de rigidez
  b = zeros(N, 1);  % lado derecho

  area = 0.5 * dx * dy; % Al ser un triangulo rectangulo y los nodos tienen dx y dy constantes. La base siempre es dx y la altura dy
  for t = 1:tamTablaElemento

    nodes = TablaElemento(t, 2:4);  % Obtenemos cada indice de los nodos del triangulo t
    coords = TablaNodo(nodes, 2:3);  % Obtenemos coordenadas [x y] de los 3 nodos

    % Obtenemos cada x e y para cada grupo de nodos
    x1 = coords(1,1); y1 = coords(1,2);
    x2 = coords(2,1); y2 = coords(2,2);
    x3 = coords(3,1); y3 = coords(3,2);

    % Vectores auxiliares para el gradiente de phi
    b_vec = [y2 - y3; y3 - y1; y1 - y2];
    c_vec = [x3 - x2; x1 - x3; x2 - x1];

    % Armamos la matriz de rigidez local (A_e)
    A_e = zeros(3,3);
    for i = 1:3
      for j = 1:3
        A_e(i,j) = (b_vec(i)*b_vec(j) + c_vec(i)*c_vec(j)) / (4*area);
      endfor
    endfor

    % "Unimos" cada A local matriz de rigidez A global
    for i = 1:3
      for j = 1:3
        A(nodes(i), nodes(j)) += A_e(i,j);
      endfor
    endfor
  endfor

  % Aplicamos las condiciones de borde y obstaculo
  for n = 1:N
    x = TablaNodo(n,2);
    y = TablaNodo(n,3);
    % En el borde superior forzamos a que u vaya a ser 1 posteriormente
    if abs(y - L) <= 0
      A(n,:) = 0;
      A(n,n) = 1;
      b(n) = 1;
    % En el borde del obstaculo forzamos a que u vaya a ser 0 posteriormente
    %elseif ((x - L/2)^2 + (y - L/2)^2) <= r^2
     % A(n,:) = 0;
      %A(n,n) = 1;
      %b(n) = 0;
    % En el borde del obstaculo forzamos a que u vaya a ser 0 posteriormente
    elseif (abs(x - 0) <= 0 || abs(x - L) <= 0) || abs(y - 0)  <= 0
      A(n,:) = 0;
      A(n,n) = 1;
      b(n) = 0;

    endif
  endfor

  % \ resuelve el sistema A*u = b, donde desconocemos u
  u = A \ b;

  % Graficamos usando patch con ayuda de una IA
  figure;
  hold on;
  axis equal;

  % Obtenemos las coordenadas X de todos los nodos
  X = TablaNodo(:,2);
  % Obtenemos las coordenadas Y de todos los nodos
  Y = TablaNodo(:,3);

  % Obtenemos los nodos que forman cada triángulo
   F = TablaElemento(:,2:4);

  % Creamos el grafico
  patch('Faces', F, 'Vertices', [X Y],'FaceVertexCData', u,'FaceColor', 'interp','EdgeColor', 'k', 'FaceAlpha', 0.95);

  title('Solución u(x,y)');
  colorbar;
  % Dibujamos el obstaculo (circulo) en rojo
  theta = linspace(0, 2*pi, 200);  % ángulos de 0 a 2pi
  x_circle = centro(1) + r * cos(theta);
  y_circle = centro(2) + r * sin(theta);
  hold on;
  plot(x_circle, y_circle, 'r-', 'LineWidth', 1.5);

endfunction

