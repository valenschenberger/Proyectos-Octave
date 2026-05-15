function estaDentro = TrianguloDentroCirculo(p1,p2,p3,TablaNodo,centro,radio)
  cond1 = (TablaNodo(p1,2) - centro(1))^2 + (TablaNodo(p1,3) - centro(2))^2 <= radio^2;
  cond2 = (TablaNodo(p2,2) - centro(1))^2 + (TablaNodo(p2,3) - centro(2))^2 <= radio^2;
  cond3 = (TablaNodo(p3,2) - centro(1))^2 + (TablaNodo(p3,3) - centro(2))^2 <= radio^2;
  estaDentro = (cond1 || cond2) || cond3;
  endfunction;
