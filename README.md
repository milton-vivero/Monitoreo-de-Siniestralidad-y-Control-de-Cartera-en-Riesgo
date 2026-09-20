# 📊 Monitoreo de Siniestralidad y Control de Cartera en Riesgo — Giro de Negocio de Seguros

> Pipeline analítico y reportería gerencial desarrollada en R para la optimización de estrategias de retención y mitigación del abandono de clientes (Churn).

---

## 🎯 Objetivo

Proporcionar una visión consolidada, predictiva y dinámica de la cartera de clientes asegurados, permitiendo a la Alta Gerencia y al equipo de Inteligencia Comercial tomar decisiones basadas en datos para:

- Identificar el volumen neto de renovaciones frente a fugas reales.
- Cuantificar el impacto financiero en dólares de la cartera en riesgo crítico.
- Segmentar de forma proporcional el comportamiento de abandono por tramos demográficos y niveles de satisfacción.

---

## 📸 Vista del Reporte

<img width="441" height="379" alt="image" src="https://github.com/user-attachments/assets/dec7fa18-888a-40b0-8778-1efd285c4c82" />

---
<img width="443" height="375" alt="image" src="https://github.com/user-attachments/assets/b7888416-77f3-4449-b6ba-c2a79f4d91de" />

---

## 🏆 KPIs Principales

| Indicador | Descripción |
| --- | --- |
| **Clientes Asegurados** | Conteo total de registros analizados en la cartera transaccional. |
| **Prima Promedio (USD)** | Media continua del costo de facturación mensual por asegurado. |
| **Siniestros Reportados** | Acumulado total de incidentes y reclamos atendidos en el periodo. |
| **Edad Promedio** | Media aritmética de la distribución demográfica de la cartera. |
| **Cartera en Riesgo (USD)** | Monto financiero comprometido de clientes insatisfechos con alta siniestralidad. |

---

## 📁 Estructura de Datos

### Tabla Base: `seguros_ecuador.csv`

| Campo | Tipo | Descripción |
| --- | --- | --- |
| `id_cliente` | Texto | Identificador único del asegurado en el sistema. |
| `provincia` | Factor | Zona geográfica de la póliza (Pichincha, Guayas, Azuay, Manabí, Tungurahua). |
| `edad` | Entero | Edad del titular de la póliza (Imputada mediante mediana poblacional). |
| `antiguedad_meses` | Entero | Meses de permanencia activa del cliente en la compañía. |
| `canal_adquisicion` | Factor | Canal comercial de origen (Asesor Directo, Banca Seguros, Broker Digital). |
| `tipo_poliza` | Factor | Categoría del producto (Individual Premium, Familiar Estándar, Corporativo). |
| `prima_mensual_usd` | Decimal | Costo de la prima mensual facturada en dólares. |
| `siniestros_reclamados` | Entero | Cantidad de siniestros reportados por el cliente. |
| `score_satisfaccion` | Entero | Calificación del servicio recibido (Escala numérica del 1 al 5). |
| `churn` | Factor | Indicador de renovación contractual de la póliza (Si / No). |

---

## 📐 Métricas y Lógica Avanzada Implementada

- **Total Primas Provincia** — *Window Function* regional para calcular la recaudación total por zona sin destruir la granularidad del registro.
- **Porcentaje Aporte Cliente** — Peso financiero de cada asegurado sobre el total de su respectiva provincia.
- **Ranking Costo Provincia** — Función de ventana estadística (`dense_rank`) para jerarquizar los clientes de mayor valor por región.
- **En Riesgo Crítico** — Condicional lógico para marcar de forma binaria a clientes con baja satisfacción y alta siniestralidad.
- **Cartera Vencida USD** — Campo calculado que cuantifica el impacto en dólares de las primas en riesgo de pérdida inminente.

---

## 📈 Visualizaciones Incluidas

| Gráfico | Tipo | Insight |
| --- | --- | --- |
| **Control de Churn** | Gráfico de barras | Contraste volumétrico directo entre clientes retenidos y fugados de la cartera. |
| **Distribución de Satisfacción** | Gráfico de dona avanzada | Análisis de degradado secuencial para auditar los niveles de experiencia del cliente. |
| **Análisis Proporcional** | Barras apiladas al 100% | Segmentación del impacto de Churn distribuido de forma relativa por tramos de edad. |

---

## 🎛️ Segmentaciones y Variables Predictivas (Machine Learning)

El pipeline integra un modelo predictivo basado en el algoritmo supervisado **Random Forest (150 árboles de decisión)** entrenado con el 80% de la muestra para clasificar las probabilidades de renovación evaluando:

- ✅ **Ubicación Geográfica** — Provincia de radicación de la póliza.
- ✅ **Experiencia y Costos** — Cruce de score de satisfacción, siniestros reportados y primas mensuales.
- ✅ **Atributos del Producto** — Tipo de póliza contratada y canal comercial de adquisición.

---

## 🛠️ Tecnologías Utilizadas

## 🛠️ Tecnologías Utilizadas

<p align="left">
<img src="https://shields.io" alt="RStudio"/>
<img src="https://shields.io" alt="R"/>
<img src="https://shields.io" alt="Markdown"/>
<img src="https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Excel"/>
</p>

---

## 👤 Autor

**Milton Vivero** — Data Science and Business Intelligence

> *Pipeline de datos diseñado para la optimización del control de siniestralidad, análisis demográfico y toma de decisiones comerciales de alto nivel.*

---

## 📄 Licencia

Este proyecto es de uso corporativo interno e intelectual del autor. Para uso comercial o distribución, contactar directamente al autor.

---

<p align="center">
<i>"Los datos bien visualizados cuentan la historia que los números solos no pueden contar."</i>
</p>
