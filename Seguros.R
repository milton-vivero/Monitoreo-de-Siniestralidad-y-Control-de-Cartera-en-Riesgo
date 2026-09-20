# PROYECTO: ANALÍTICA PREDICTIVA DE CHURN

##CARGA DE LIBRERÍAS CORE PARA EL PIPELINE ====
# tidyverse maneja la minería de datos (dplyr) y los gráficos profesionales (ggplot2).
# caret divide la muestra y evalúa el modelo (Matriz de Confusión).
# randomForest activa el algoritmo de Inteligencia Artificial.
library(tidyverse)    
library(caret)        
library(randomForest) 

# CONFIGURACIÓN DE SEMILLA DE CONSISTENCIA ====
# set.seed asegura que los números aleatorios sean idénticos en cada ejecución.
# n_clientes define el tamaño de nuestra muestra comercial.
set.seed(2026) 
n_clientes <- 1500

# SIMULACIÓN DE LA CARTERA DE CLIENTES EN ECUADOR ====
# data.frame estructura la tabla inicial con variables demográficas y de negocio.
provincias <- c('Pichincha', 'Guayas', 'Azuay', 'Manabí', 'Tungurahua')
pesos_provincias <- c(0.40, 0.35, 0.12, 0.08, 0.05) 

bd_seguros <- data.frame(
  id_cliente = paste0('EC-', 10000:(9999 + n_clientes)),
  provincia = sample(provincias, n_clientes, replace = TRUE, prob = pesos_provincias),
  edad = sample(18:70, n_clientes, replace = TRUE),
  antiguedad_meses = sample(1:60, n_clientes, replace = TRUE),
  canal_adquisicion = sample(c('Asesor Directo', 'Banca Seguros', 'Broker Digital'), n_clientes, replace = TRUE, prob = c(0.3, 0.5, 0.2)),
  tipo_poliza = sample(c('Individual Premium', 'Familiar Estándar', 'Corporativo Empresarial'), n_clientes, replace = TRUE, prob = c(0.4, 0.4, 0.2)),
  prima_mensual_usd = round(runif(n_clientes, 15.0, 180.0), 2),
  siniestros_reclamados = sample(0:4, n_clientes, replace = TRUE, prob = c(0.65, 0.22, 0.09, 0.03, 0.01)),
  score_satisfaccion = sample(1:5, n_clientes, replace = TRUE, prob = c(0.05, 0.15, 0.30, 0.35, 0.15))
)

# INYECCIÓN MATEMÁTICA DEL ENIGMA DEL CHURN (FUGA) ====
# Se calcula una probabilidad lógica basada en insatisfacción y precios altos.
prob_fuga <- 0.10 + (bd_seguros$siniestros_reclamados * 0.15) + ((6 - bd_seguros$score_satisfaccion) * 0.12) + ifelse(bd_seguros$prima_mensual_usd > 120, 0.10, 0) - (bd_seguros$antiguedad_meses * 0.003)
prob_fuga <- pmin(pmax(prob_fuga, 0.02), 0.98) 
bd_seguros$churn <- as.factor(ifelse(runif(n_clientes) < prob_fuga, "Si", "No"))

# SIMULACIÓN DE SUCIEDAD DE DATOS (NULOS Y ANOMALÍAS) ====
# Añade valores vacíos (NA) y valores erróneos (-99) para forzar la depuración.
bd_seguros$edad[sample(1:n_clientes, 20)] <- NA
bd_seguros$edad[sample(1:n_clientes, 5)] <- -99
bd_seguros$prima_mensual_usd[sample(1:n_clientes, 15)] <- NA

# DATA CLEANING (TRATAMIENTO DE OUTLIERS Y MEDIANAS) ====
# Limpia las edades negativas e imputa los NAs usando la mediana poblacional.
bd_limpia <- bd_seguros %>%
  mutate(edad = ifelse(edad < 0, NA, edad)) %>%
  mutate(
    edad = ifelse(is.na(edad), median(edad, na.rm = TRUE), edad),
    prima_mensual_usd = ifelse(is.na(prima_mensual_usd), median(prima_mensual_usd, na.rm = TRUE), prima_mensual_usd)
  ) %>%
  mutate(
    provincia = as.factor(provincia), 
    canal_adquisicion = as.factor(canal_adquisicion), 
    tipo_poliza = as.factor(tipo_poliza)
  )

# INGENIERÍA DE VARIABLES ====
# group_by + mutate calcula la recaudación total de primas por provincia sin alterar las filas.
# Añade columnas de control para medir el dinero de la Cartera en Riesgo Crítico.
bd_procesada <- bd_limpia %>%
  group_by(provincia) %>%
  mutate(
    Total_Primas_Provincia = sum(prima_mensual_usd),
    Porcentaje_Aporte_Cliente = (prima_mensual_usd / Total_Primas_Provincia) * 100,
    Ranking_Costo_Provincia = dense_rank(desc(prima_mensual_usd))
  ) %>%
  ungroup() %>%
  mutate(
    en_riesgo_critico = ifelse(score_satisfaccion <= 2 & siniestros_reclamados >= 2, 1, 0),
    cartera_vencida_usd = ifelse(en_riesgo_critico == 1, prima_mensual_usd, 0)
  )

# SEPARACIÓN DE MUESTRAS PARA INTELIGENCIA ARTIFICIAL =====
# createDataPartition divide los datos: 80% para entrenar la IA, 20% para evaluarla.
indice <- createDataPartition(bd_procesada$churn, p = 0.8, list = FALSE)
train_set <- bd_procesada[indice, ]
test_set  <- bd_procesada[-indice, ]

# --- PASO 10: ENTRENAMIENTO DEL MODELO DE APRENDIZAJE AUTOMÁTICO ---
# randomForest clasifica y predice el Churn evaluando todas las columnas operativas.
modelo_churn <- randomForest(
  churn ~ provincia + edad + antiguedad_meses + canal_adquisicion + tipo_poliza + prima_mensual_usd + siniestros_reclamados + score_satisfaccion, 
  data = train_set, 
  ntree = 150
)

# VALIDACIÓN MATRIZ DE CONFUSIÓN Y PRECISIÓN ====
# Mide la efectividad predictiva del algoritmo contra datos reales que nunca vio.
predicciones <- predict(modelo_churn, test_set)
matriz <- confusionMatrix(predicciones, test_set$churn)
print(matriz$overall["Accuracy"])

# CONSTRUCCIÓN DE LAS CAPAS GRÁFICAS DE ALTO NIVEL ====
# Prepara tablas de frecuencias y configura los diagramas en memoria interna.
df_satisfaccion <- bd_procesada %>% count(score_satisfaccion) %>% mutate(porcentaje = n / sum(n) * 100)

grafico_barras <- ggplot(bd_procesada, aes(x = churn, fill = churn)) +
  geom_bar(width = 0.6) +
  geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5, fontface = "bold", size = 4.5) +
  scale_fill_manual(values = c("No" = "#A855F6", "Si" = "#6B21A8")) + 
  labs(title = "Control de Churn (Renovación de Pólizas)", x = "¿El cliente renovó?", y = "Cantidad de Clientes") +
  theme_minimal(base_size = 12) + theme(legend.position = "none", plot.title = element_text(face = "bold"))

grafico_pastel <- ggplot(df_satisfaccion, aes(x = "", y = porcentaje, fill = as.factor(score_satisfaccion))) +
  geom_bar(stat = "identity", width = 1, color = "white") + coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(porcentaje, 1), "%")), position = position_stack(vjust = 0.5), fontface = "bold", color = "white") +
  scale_fill_manual(values = c("1" = "#C084FC", "2" = "#A855F7", "3" = "#9333EA", "4" = "#7E22CE", "5" = "#581C87")) +
  labs(title = "Distribución por Nivel de Satisfacción (1 al 5)", fill = "Nivel") +
  theme_void(base_size = 12) + theme(plot.title = element_text(face = "bold"))

grafico_densidad <- ggplot(bd_procesada, aes(x = prima_mensual_usd, y = edad)) +
  geom_density_2d_filled(alpha = 0.85, bins = 8) +
  geom_jitter(alpha = 0.15, size = 1, color = "white", width = 0.5, height = 0.5) +
  facet_wrap(~ churn, labeller = as_labeller(c("No" = "Clientes Retenidos (Leales)", "Si" = "Clientes Fugados (Churn)"))) +
  scale_fill_viridis_d(option = "purple") + 
  labs(title = "Mapa de Densidad Comercial: Zonas Críticas de Fuga", x = "Prima Mensual (USD)", y = "Edad del Asegurado", fill = "Densidad") +
  theme_minimal(base_size = 12) + 
  theme(
    plot.title = element_text(face = "bold", color = "#1E293B", size = 14),
    strip.background = element_rect(fill = "#6B21A8"), 
    strip.text = element_text(face = "bold", color = "white")
  )

# DESPLIEGUE VISUAL EN EL PANEL "PLOTS" DE RSTUDIO ====
# Envía los objetos gráficos al visor nativo. Recuerda navegar con las flechas (<-).
print(grafico_barras)
print(grafico_pastel)
print(grafico_densidad)

# GUARDADO AUTOMÁTICO DEL DATASET OPTIMIZADO =====
write.csv(bd_procesada, "seguros_atlantida_ecuador.csv", row.names = FALSE)
print("Pipeline ejecutado con éxito total. Revisa el panel Plots de RStudio.")
