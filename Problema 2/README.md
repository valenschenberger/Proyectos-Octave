## 📂 Problema 2
# Simulación de Propagación de Señal con FEM 2D

Este proyecto implementa el Método de Elementos Finitos (FEM) en 2D utilizando **Octave** para resolver la ecuación de Laplace. El modelo simula la distribución de la intensidad de una señal inalámbrica dentro de un recinto cuadrado que contiene un obstáculo circular en el centro.

## 🧮 Formulación Matemática

Se busca la función de intensidad de señal $u(x,y)$ que satisface la ecuación de Laplace en el dominio:
$$\Delta u = 0$$

**Condiciones de Borde:**
* **Dirichlet:** $u = 1$ en el borde superior (emisor) y $u = 0$ en el borde inferior (ausencia de señal).
* **Neumann Homogénea:** $\frac{\partial u}{\partial n} = 0$ en los laterales y en el contorno del obstáculo circular (sin flujo/rebote de señal).

## ⚙️ Implementación Numérica

1. **Malla Triangular:** El dominio continuo se discretiza en una cuadrícula regular, donde cada cuadrado se divide en dos triángulos. Se generan las estructuras `TablaNodo` y `TablaElemento`, excluyendo dinámicamente los triángulos que caen dentro del obstáculo central.
2. **Matriz de Rigidez:** Se construyen las matrices locales $A_e$ para cada triángulo basándose en el gradiente de las funciones de forma, y luego se ensamblan en la matriz global $A$.
3. **Resolución:** Se imponen las condiciones de contorno mixtas modificando directamente el sistema lineal $Au = b$ y se resuelve para obtener la intensidad en cada nodo.

## 🚀 Uso de los Scripts

El flujo principal se ejecuta desde `TrianguloFEM.m`, el cual depende de la función auxiliar `TrianguloDentroCirculo.m` para validar la posición geométrica de los nodos respecto al obstáculo.

Para ejecutar la simulación y generar el mapa de color interactivo en Octave, utiliza el siguiente comando en la ventana de comandos:

```matlab
% Sintaxis: TrianguloFEM(divisiones_de_la_malla, longitud_del_recinto)
% Ejemplo usando 50 divisiones para una recinto de L=10:

TrianguloFEM(50, 10)
