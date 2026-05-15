# Trabajo Final: Análisis Numérico en Octave

Este repositorio contiene la resolución e implementación numérica de dos modelos de simulación utilizando **Octave**. Los problemas abordan el modelado matemático mediante ecuaciones diferenciales parciales (EDP), resueltas a través de métodos de diferencias finitas y elementos finitos (FEM).

**Autora:** Valentina  
**Institución:** Universidad Tecnológica Nacional (UTN)

---

## 📂 Problema 1: Flujo de información en redes neuronales profundas
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
