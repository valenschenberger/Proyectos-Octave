# Trabajo Final: Análisis Numérico en Octave

Este repositorio contiene la resolución e implementación numérica de dos modelos de simulación utilizando **Octave**. Los problemas abordan el modelado matemático mediante ecuaciones diferenciales parciales (EDP), resueltas a través de métodos de diferencias finitas y elementos finitos (FEM).

**Institución:** Universidad Tecnológica Nacional (UTN)

--- 

## 📂 Problema 1
Este modelo simula cómo fluye y se disipa la información a lo largo de una red neuronal continua utilizando una EDP parabólica en una dimensión.

* **Ecuación:** `∂u/∂t = ∂²u/∂x² - u`
* **Método Numérico:** Diferencias Finitas (Esquema Explícito).
* **Condiciones de Borde:** Dirichlet constante en la entrada y Neumann homogénea en la salida.
* **Archivo principal:** `TPRed1.m`

### Uso
Para ejecutar la simulación, utiliza la función con sus parámetros (Longitud, Tiempo, alpha, beta, condición inicial, nodos espaciales, pasos temporales):
```matlab
% Ejemplo de ejecución
TPRed1(1, 1, 0.01, 0.1, 1, 50, 50)
```

---

## 📂 Problema 2
Este modelo simula la distribución de la intensidad de una señal inalámbrica dentro de un recinto cuadrado que contiene un obstáculo circular en el centro.

* **Ecuación:** `Δu = 0` (Ecuación de Laplace)
* **Método Numérico:** Elementos Finitos en 2D (FEM).
* **Condiciones de Borde:** Dirichlet en los bordes superior e inferior, y Neumann homogénea en los laterales y en el contorno del obstáculo.
* **Archivo principal:** `TrianguloFEM.m`

### Uso
Para ejecutar la simulación y generar el mapa de color interactivo, utiliza la función con sus parámetros (divisiones de la malla, longitud del recinto):
```matlab
% Ejemplo de ejecución
TrianguloFEM(50, 10)
