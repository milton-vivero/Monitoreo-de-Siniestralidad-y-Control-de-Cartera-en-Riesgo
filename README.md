# 📊 Monitoreo de Siniestralidad y Control de Cartera en Riesgo

> Pipeline analítico y reportería gerencial desarrollada en **R** para apoyar la optimización de estrategias de retención, análisis de siniestralidad y mitigación del abandono de clientes (*Churn*).

---

## 🎯 Objetivo

Proporcionar una visión consolidada, analítica y predictiva de la cartera de clientes asegurados, facilitando la toma de decisiones basada en datos para la Alta Gerencia y el área de Inteligencia Comercial.

El proyecto permite:

- Identificar el volumen de renovaciones frente a las fugas reales de clientes.
- Cuantificar el impacto financiero de la cartera en riesgo.
- Analizar la relación entre satisfacción, siniestralidad y permanencia.
- Segmentar el comportamiento de abandono según variables demográficas y comerciales.
- Identificar clientes que requieren acciones de seguimiento y retención.

---

## 📸 Vista del Reporte

<p align="center">
  <img width="441" alt="Vista 1 del reporte analítico" src="https://github.com/user-attachments/assets/dec7fa18-888a-40b0-8778-1efd285c4c82" />
</p>

<p align="center">
  <img width="443" alt="Vista 2 del reporte analítico" src="https://github.com/user-attachments/assets/b7888416-77f3-4449-b6ba-c2a79f4d91de" />
</p>

---

## 🏆 Indicadores Principales

| Indicador | Descripción |
| --- | --- |
| **Clientes Asegurados** | Conteo total de registros analizados en la cartera transaccional. |
| **Prima Promedio (USD)** | Promedio del costo de facturación mensual por asegurado. |
| **Siniestros Reportados** | Total acumulado de incidentes y reclamos reportados en el periodo. |
| **Edad Promedio** | Promedio de edad de los clientes analizados. |
| **Cartera en Riesgo (USD)** | Monto financiero asociado a clientes con condiciones de riesgo de abandono. |

---

## 📁 Estructura de Datos

### Tabla base: `seguros_ecuador.csv`

| Campo | Tipo | Descripción |
| --- | --- | --- |
| `id_cliente` | Texto | Identificador único del asegurado. |
| `provincia` | Factor | Provincia asociada a la póliza. |
| `edad` | Entero | Edad del titular de la póliza. |
| `antiguedad_meses` | Entero | Meses de permanencia activa del cliente. |
| `canal_adquisicion` | Factor | Canal comercial de origen. |
| `tipo_poliza` | Factor | Categoría del producto contratado. |
| `prima_mensual_usd` | Decimal | Valor de la prima mensual facturada en dólares. |
| `siniestros_reclamados` | Entero | Número de siniestros reportados por el cliente. |
| `score_satisfaccion` | Entero | Calificación del servicio en una escala del 1 al 5. |
| `churn` | Factor | Indicador de renovación contractual de la póliza. |

---

## 📐 Métricas y Lógica Analítica

- **Total Primas Provincia:** cálculo de la recaudación total por provincia mediante funciones de ventana.
- **Porcentaje Aporte Cliente:** peso financiero de cada asegurado dentro del total de su provincia.
- **Ranking Costo Provincia:** clasificación de clientes según su aporte económico regional mediante `dense_rank`.
- **En Riesgo Crítico:** indicador lógico para identificar clientes con baja satisfacción y alta siniestralidad.
- **Cartera Vencida USD:** cálculo del impacto económico de las primas asociadas a clientes en riesgo de pérdida.

---

## 📈 Visualizaciones Incluidas

| Visualización | Tipo | Objetivo analítico |
| --- | --- | --- |
| **Control de Churn** | Gráfico de barras | Comparar clientes retenidos y clientes que abandonaron la cartera. |
| **Distribución de Satisfacción** | Gráfico de dona | Examinar la distribución de los niveles de satisfacción. |
| **Análisis Proporcional** | Barras apiladas al 100 % | Analizar el comportamiento del churn por tramos de edad. |

---

## 🤖 Modelo Predictivo

El pipeline incorpora un modelo supervisado basado en **Random Forest**, configurado con **150 árboles de decisión** y entrenado con el **80 % de la muestra**, según la configuración del proyecto.

Las variables consideradas incluyen:

- **Ubicación geográfica:** provincia de la póliza.
- **Experiencia y costos:** satisfacción, siniestros reportados y prima mensual.
- **Características del producto:** tipo de póliza y canal de adquisición.

> El modelo debe evaluarse mediante métricas de clasificación y validación adecuada antes de utilizar sus resultados en procesos reales de decisión comercial.

---

## 🛠️ Tecnologías Utilizadas

<p align="left">
  <img src="https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white" alt="R" />
  <img src="https://img.shields.io/badge/RStudio-75AADB?style=for-the-badge&logo=rstudioide&logoColor=white" alt="RStudio" />
  <img src="https://img.shields.io/badge/Tidyverse-1F9E89?style=for-the-badge&logo=r&logoColor=white" alt="Tidyverse" />
  <img src="https://img.shields.io/badge/Machine_Learning-FF6F00?style=for-the-badge&logo=scikitlearn&logoColor=white" alt="Machine Learning" />
  <img src="https://img.shields.io/badge/Random_Forest-2E8B57?style=for-the-badge&logo=databricks&logoColor=white" alt="Random Forest" />
  <img src="https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Excel" />
  <img src="https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white" alt="Markdown" />
  <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub" />
</p>

### Herramientas y enfoques aplicados

- Limpieza y transformación de datos con R.
- Análisis exploratorio de datos.
- Funciones de ventana y segmentación analítica.
- Visualización de indicadores comerciales.
- Modelado predictivo mediante Random Forest.
- Documentación técnica en Markdown.

---

## 👤 Autor

**Milton Vivero**  
*Data Science and Business Intelligence*

> Pipeline de datos orientado al análisis de siniestralidad, comportamiento demográfico y apoyo a la toma de decisiones comerciales en el sector asegurador.

---

## 📄 Licencia

Este proyecto es de uso corporativo interno y propiedad intelectual del autor. Para solicitar autorización de uso comercial o distribución externa, contactar directamente al autor.

---

<p align="center">
  <i>“Los datos bien visualizados cuentan la historia que los números solos no pueden contar.”</i>
</p>
