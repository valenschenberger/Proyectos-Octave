function U = Triangulo(divisiones,L)
  nodosx = (1:divisiones)
  nodosy = (1:divisiones)'
  r = L/6;
  U = zeros(divisiones,divisiones);
  U(1,1:divisiones) = ones(divisiones,1)

  TablaNodo = zeros(divisiones^2,3)
  acum = 1;
  for fila = [1:divisiones^2]
    TablaNodo(fila,3) = fila;
    TablaNodo(fila,1) = fila;

    TablaNodo(fila,2) = acum
    if mod(fila,3) == 0
      acum = acum + 1;
    endif;
   endfor;
  endfunction
