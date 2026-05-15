function U = TPRed1(L, T, alpha, beta, u0, N, M)
 % L limite del dom de x, T lim del dom de T, alpha coef difusion, beta es disipacion,
 % u0 estado inicial, N cant de ptos de x, M cant de ptos en T
 dx = L/(N-1);
 dt = T/M;
 r = (dt*alpha)/(dx^2);
 % 0  x   x   x   x   L
 %    x   x   x   x
 %    x   x   x   x
 %    x   x   x   x
 % T  x   x   x   x

 U = zeros(N,M);            % rellenamos la matriz, condion de borde (B) y (C)
 U(2:N,1) = ones(N-1,1).*u0;   % U(1,:) = u0; % condicion de borde (A)

 % 0  0    0   0   0   L
 %    u0   0   0   0
 %    u0   0   0   0
 %    u0   0   0   0
 % T  u0   0   0   0

% armar Matriz M
  for j = [2:M-1]
      for i = [2:N-1]
          % u(i, j+1) = u(i, j) + r*(u(i+1, j) - 2*u(i, j) + u(i-1, j)) - dt*beta*u(i, j))
          U(i, j) = U(i, j-1) * (1 - 2*r - dt*beta) + r*U(i-1, j-1) + r*U(i+1, j-1);
      endfor;
      U(N, j) = U(N-1, j); % Condición Neumann en x=L
  endfor;
  if r < 1/2
    imagesc(linspace(0, L, N), linspace(0, T, M), U);
  % imagesc -> pinta la matriz usando colores según los valores de cada elemento.
  % linspace(0, T, M) -> genera un vector de M puntos entre 0 y T, representa el eje horizontal: tiempo
  % linspace(0, L, N) -> genera un vector de N puntos entre 0 y L, representa el eje vertical: posición (x)
    colorbar;
    xlabel('Posición x');          % agrega nombre
    ylabel('Tiempo t');            % agrega nombre
    title('Evolución de u(x,t)');  % agrega titulo
    grid on;
  endif;

endfunction;







