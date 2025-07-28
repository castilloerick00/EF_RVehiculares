# Simulación Avanzada de Tráfico y Redes Vehiculares (5G-V2X & RL)

![Python](https://img.shields.io/badge/Python-3.8%2B-blue.svg)
![OMNeT++](https://img.shields.io/badge/OMNeT++-5.6-green.svg)
![SUMO](https://img.shields.io/badge/SUMO-1.8.0%2B-orange.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

Este repositorio alberga dos proyectos de simulación complementarios que exploran la intersección de las redes de comunicación de próxima generación y la inteligencia artificial para la gestión del tráfico urbano.

1.  **Simulación de Redes Vehiculares 5G (Simu5G)**: Un entorno de simulación en OMNeT++ que modela la comunicación Vehículo-a-Infraestructura (V2I) utilizando una arquitectura avanzada de **Conectividad Dual 4G/5G (EN-DC)**.
2.  **Control de Semáforos con RL Multi-Agente**: Un sistema basado en Python y PyTorch que utiliza **Aprendizaje por Refuerzo (RL)** para entrenar a múltiples agentes (semáforos) a coordinarse y optimizar el flujo de tráfico en una red urbana.

Ambos proyectos utilizan **SUMO (Simulation of Urban MObility)** como simulador de tráfico subyacente, representando dos capas clave de un sistema de transporte inteligente.

---

## 🌐 Parte 1: Simulación de Redes Vehiculares 5G con Dual Connectivity

Esta simulación, desarrollada dentro del framework Simu5G, se centra en la capa de comunicación de la red vehicular. Modela un escenario de autopista donde los vehículos se conectan a una red celular heterogénea.

### Características Principales
* **Arquitectura EN-DC**: Utiliza un eNodeB (4G) como **Nodo Maestro** y un gNodeB (5G) como **Nodo Secundario**.
* **Interfaz X2**: El eNodeB y el gNodeB están interconectados a través de una interfaz X2 para la coordinación y la división de datos.
* **Split Bearer**: El tráfico de datos (VoIP) hacia el vehículo se divide entre los enlaces de radio 4G y 5G para mejorar el rendimiento y la fiabilidad.
* **Escenario V2I**: Modela la comunicación entre los vehículos y la infraestructura de red.

### Requisitos
* OMNeT++ (v5.6.2 o superior)
* INET Framework (v4.2.2 o superior)
* Simu5G (v1.2.2 o superior)
* Veins (v5.2 o superior)
* SUMO (v1.8.0 o superior)

### Ejecución
1.  Asegúrate de que todas las dependencias estén instaladas y configuradas correctamente.
2.  Abre el IDE de OMNeT++ e importa el proyecto `simu5g`.
3.  Navega hasta el directorio de la simulación: `simulations/NR/simu5G/`.
4.  Abre el archivo `omnetpp.ini` y selecciona la configuración `[Config Cars-SplitBearer-DL]`.
5.  Ejecuta la simulación.

---

## 🚦 Parte 2: Control de Semáforos con RL Multi-Agente

Este proyecto, contenido en la carpeta `multiagente/`, utiliza Aprendizaje por Refuerzo Multi-Agente para entrenar un sistema de control de semáforos inteligente. El objetivo es minimizar la congestión vehicular reduciendo los tiempos de espera.

### Características Principales
* **Algoritmo PPO**: Implementa Proximal Policy Optimization, un algoritmo de RL de última generación.
* **Arquitectura Actor-Crítico**: El modelo de red neuronal aprende tanto una política (qué acción tomar) como una función de valor (qué tan buena es la situación actual).
* **Entorno Multi-Agente**: Cada intersección con semáforo es controlada por un agente independiente que aprende a coordinarse con sus vecinos.
* **Simulación en SUMO**: Utiliza SUMO para modelar el comportamiento del tráfico y obtener métricas de estado (colas, velocidad, etc.) para los agentes.

### Análisis del Código
El proyecto se encuentra en un notebook de Jupyter (`.ipynb`) y se estructura de la siguiente manera:
1.  **Configuración del Entorno**: Instala dependencias (SUMO, PyTorch) y genera mediante programación un escenario de red urbana de 2x2 intersecciones en SUMO.
2.  **Definición del Entorno RL**: Se crea una clase `SumoEnv` que sirve de puente entre el agente de RL y la simulación de SUMO.
3.  **Modelo PPO Actor-Crítico**: Se define la arquitectura de la red neuronal en PyTorch.
4.  **Bucle de Entrenamiento**: El script principal inicializa y entrena a los agentes.
5.  **Evaluación**: Al final, se compara el rendimiento del agente de RL entrenado contra un sistema de control de semáforos de tiempos fijos para cuantificar la mejora.

### Requisitos
* Python 3.8+
* SUMO (instalado y accesible desde la línea de comandos)
* Bibliotecas de Python: `torch`, `traci`, `numpy`, `pandas`, `matplotlib`.

### Ejecución
1.  Abre el notebook de Jupyter que se encuentra en la carpeta `multiagente/`.
2.  Ejecuta las celdas de forma secuencial. El notebook es autocontenido: instalará dependencias, creará el escenario, definirá las clases y finalmente ejecutará el entrenamiento y la evaluación.

---

## 📈 Resultados Destacados

* **Simulación 5G**: La simulación V2I demuestra la viabilidad de la Conectividad Dual para aplicaciones vehiculares de baja latencia. Los análisis de logs confirman el correcto funcionamiento del stack de protocolos, logrando latencias de red ultra-bajas (**~4.4 ms**) para el tráfico VoIP.
* **Agente RL**: El agente entrenado para el control de semáforos muestra una mejora significativa sobre los sistemas tradicionales. La evaluación final indica una **reducción del 45.26% en el tiempo medio de espera** y un **23.25% en la duración media del viaje** en comparación con un sistema de tiempos fijos.

---

## 📂 Estructura del Repositorio

- **multiagente/**
  - `entrenamiento_rl_trafico.ipynb`
- **simu5g/**
  - **simulations/**
    - **NR/**
      - **simu5G/** *(<-- SIMULACIÓN PERSONALIZADA)*
        - `Highway.ned`
        - `omnetpp.ini`
  - `... (resto de la estructura de Simu5G)`
- `README.md`
