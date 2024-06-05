
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Progetto Irene Altea De Vincenzo
## 2024

### OBIETTIVO DEL PROGETTO:
Tra il 25-26 Aprile 2022, l'isola di Stromboli è stata interessata da un disastroso incendio che ha bruciato gran parte della vegetazione nella porzione NE dell'isola. Con questo programma, miriamo ad analizzare la situazione pre- e post-incendio per studiare l'area bruciata. A tal fine, eseguiremo le seguenti operazioni:

1. Caricare e confrontare le immagini in "falsi colori".
2. Calcolare il BAI (indice di area bruciata).
3. Calcolare il NBR (indice normalizzato di bruciatura).
4. Creare grafici riassuntivi.

### (1) CARICARE E CONFRONTARE IMMAGINI IN FALSI COLORI

#### CARICAMENTO DELLE LIBRERIE NECESSARIE
```{r, eval=F}
library(terra)  # Per lavorare con dati raster e vettoriali.
library(ggplot2)  # Creazione di grafici statistici.
library(imageRy)  # Gestione delle immagini.
library(raster)  # Lavoro con dati raster, come immagini satellitari o mappe.
library(patchwork)  # Composizione di più grafici creati con ggplot2 in un’unica visualizzazione.
library(viridis)  # Creazione di mappe di colore visibili anche ai daltonici. 
```

#### IMPOSTARE WORKING DIRECTORY
```{r, eval=F}
setwd("C:/Users/irene/Downloads/Tele-project/sentinel/") 
getwd() 
```
>**Note**  
La funzione "setwd()" serve ad impostare la working directory.
La funzione "getwd()" serve a richiamarla per assicurarci che sia stata impostata correttamente.

#### IMPORTAZIONE DATI
```{r, eval=F}
# Carico i due file raster
pre_fire <- rast("pre_fire_27apr.jpg")
post_fire <- rast("post_fire_14sett.jpg")
```
>**Note** 
Per questo progetto sono state utilizzate immagini in "false color" (falso colore), basate sulle bande B8, B4, B3.
Questa visualizzazione permette di visualizzare:
+ In rosso: la copertura vegetale (in rosso) 
+ In grigio: terreno esposto o un'area bruciata

#### PLOT DATI
Creiamo un layout a due colonne per visualizzare le immagini pre e post-incendio.
```{r, eval=F}
# Creo un multiframe con le due immagini
conf_pre_post_fire <- par(mfrow=c(1,2))
plot(pre_fire, main="4 Aprile")
plot(post_fire, main="14 Settembre")
```

### (2) CALCOLARE IL BAI (INDICE AREA BRUCIATA)
Il BAI si basa sulla sottrazione delle bande 8 tra due immagini temporali per visualizzare un’area bruciata. 
Questo metodo si basa sulla differenza di riflettanza tra le immagini pre e post-incendio. 
Le aree non bruciate dovrebbero mostrare poca o nessuna differenza, mentre le aree bruciate mostreranno una differenza significativa a causa della perdita di vegetazione.

#### Calcolo la differenza tra la banda 8 dei due raster
```{r, eval=F}
# Faccio la differenza tra i due raster
band8_diff = post_fire[[1]] - pre_fire[[1]]

# Effettuo il plot
plot(band8_diff, col=viridis(100), main="Differenza pre- post- incendio")
```
>**Note**  
Per identificare le aree bruciate in modo più accurato, è importante introdurre una soglia che ci permetta di distinguere tra valori negativi e positivi nel plot.
Le aree bruciate corrispondono alle aree caratterizzate da valori negativi. 
Introdurre una soglia ci aiuta ad evidenziale solo le aree effettivamente bruciate

#### Introduzione soglia e applicazione al plot
```{r, eval=F}
# Definisco la soglia
soglia <- -50 

# Applico la soglia al mio dato
burned_areas <- band8_diff < soglia  
```
>**Soglia** 
Identifico come "area bruciata" unicamente le aree al di sotto nel valore soglia

#### Salvo plot e visualizzo risultati
```{r, eval=F}
# Plotto dati
area_bruc <- plot(burned_areas, main="Aree bruciate o esposte")

# Salvo raster
writeRaster(burned_areas, "area_bruc.tif", overwrite=TRUE)

# Rinomino il nuovo raster e lo carico
risultato <- rast("area_bruc.tif")
```
>**Dimensioni raster** Guardando le dimensioni del raster da noi creato, notiamo che ha una risoluzione 1x1 m --> quest'informazione ci sarà utile per calcolare l'area bruciata

#### CALCOLO ESTENSIONE AREA BRUCIATA
Calcolo l'area bruciata/ esposta moltiplicando (n°celle non vuote) * (risoluzione raster al quadrato) 

```{r, eval=F}
# Frequenza classi
freq_classi <- freq(risultato)

# Calcolo area bruciata
A= 8553*(1m)^2= 8553m^2
```

### CALCOLO NBR (INDICE NORMALIZZATO DI BRUCIATURA)
Le immagini satellitari possono essere composte da diverse bande di dati. Ogni banda rappresenta una specifica gamma di lunghezze d’onda e può essere utilizzata per estrarre informazioni specifiche. Tra le bande più comuni abbiamo:
+ B2= BLUE
+ B3= GREEN
+ B4= RED
+ B8= NIR (banda del vicino infrarosso)
+ B12= SWIR (banda del corto infrarosso)

Per calcolare NBR ho bisogno delle bande NIR E SWIR:

NBR = (NIR - SWIR) / (NIR + SWIR)

#### CREO FUNZIONE PER CALCOLARE NBR
```{r, eval=F}
nbr <-function(nir, swir) {
  nbr_output <- ((nir-swir)/(nir+swir)) # Scrivo la mia funzione
  return(nbr_output) # "Return" mi ha l'output di uscita della mia funzione
}
```

#### CREO LISTA DATI
Trattandosi di molti nomi da scrivere per poter importare i miei dati, potrebbe essere utile creare una lista che mostri i nomi di dati da importare
```{r, eval=T}
# Creo lista
list_project <- list.files(path = "C:/Users/irene/Downloads/Tele-project/sentinel", full.names = FALSE)

# Visualizzo lista
print(list_project)

```

#### IMPORTO DATI
```{r, eval=F}
# 27 APRILE BANDE
apr27_b8 <- rast("27apr_B8.tiff")
apr27_b12 <- rast("27apr_B12.tiff")

# 14 SETTEMBRE BANDE
sett14_b8 <- rast("sett14_B8.tiff")
sett14_b12 <- rast("sett14_B12.tiff")
```

#### CALCOLO NBR PRE-INCENDIO
```{r, eval=F}
# Richiamo la funzione con "nbr" e gli assegno 2 valori
NBR_apr <- nbr(apr27_b8, apr27_b12) 

# Faccio il plot
plot_NBR_apr <- plot(NBR_apr, col=magma(100), main="NBR 27 APRILE") 
```
>**Nota**
I colori più scuri identificheranno le aree di terreno esposte/ non vegetate

Definisco una soglia che valuti solo le aree di "suolo scoperto" (ESPOSTO + BRUCIATO)
```{r, eval=F}
# Definisco soglia
soglia_apr <- 0.20

# Applico soglia al mio plot
plot_NBR_apr_depurato <- NBR_apr < soglia_apr 

# Nuovo plot
plot(plot_NBR_apr_depurato, main="NBR Aprile corretto")

```

Dopodichè, eseguendo lo stessoo procedimento, posso calcolare anche l'NBR POST - INCENDIO

#### CONFRONTO DATI 
Una volta ottenuti i dati, li plotto insieme per eseguire un confronto

```{r, eval=F}
# Multiframe
par(mfrow=c(2,3))
plot(plot_NBR_apr_depurato, col=viridis(2), main="NBR 27 Aprile")
plot(plot_NBR_sett_depurato, col=viridis(2), main="NBR 14 Settembre")

```

Per poter studiare le variazioni tra i due raster ed effettuare operazioni è importante ricampionarli.
Per farlo:
1. Salvo i raster creati
```{r, eval=F}
writeRaster(plot_NBR_apr_depurato, "plot_NBR_apr_depurato.TIFF", overwrite=TRUE)
writeRaster(plot_NBR_sett_depurato, "plot_NBR_sett_depurato.TIFF", overwrite=TRUE)
```
2. Richiamo i nuovi raster e gli assegno un nome
```{r, eval=F}
april_nbr <-rast("plot_NBR_apr_depurato.TIFF")
sett_nbr <- rast("plot_NBR_sett_depurato.TIFF")
```
3. Ricampiono i raster con la funzione "resample()"
```{r, eval=F}
resmask <- resample(sett_nbr, april_nbr)
writeRaster(resmask, "resmask.TIFF", overwrite=TRUE)
sett_nbr_crop <- rast("resmask.TIFF")
```

Ora posso effettuare la differenza tra i due raster:
```{r, eval=F}
# Differenza
diff <- (sett_nbr_crop - april_nbr)

# Plot
plot(diff, col=viridis(3), main="Differenza NBR pre- post- incendio")

```
>**NB** 
Le aree con valori positivi sono le aree che sono state bruciate dall'incendio o che hanno subito una riduzione della vegetazione.

### GRAFICI RIASSUNTIVI
Dai dati ottenuti, elabolo rei grafici riassuntivi.
Per farlo:

1. Calcolo frequenza delle classi
```{r, eval=F}
freq_april_nbr <- freq(april_nbr)
freq_april_nbr
```
2. Calcolo numero celle totali nel raster
```{r, eval=F}
tot_celle_apr <- ncell(april_nbr)
```
3. Calcolo le proporzioni per le varie celle 
```{r, eval=F}
prop_celle_sett <- freq_sett_nbr_crop/tot_celle_sett
prop_celle_sett
```
4. Calcolo percentuali suolo/vegetazione
```{r, eval=F}
percent_sett <- prop_celle_sett*100
percent_sett
```

Una volta eseguiti questi passaggi sia per entrambi i raster, otterrò due tabelle di dati, da cui posso estrarre i valori percentuali per creare i grafici
```{r, eval=F}
# Tabella risutante
# layer               value       count
# 0.0001452289   0.0000000000   90.920329
# 0.0001452289   0.0001452289   9.079671

# Tabella risultante
# layer               value       count
# 0.0001452289   0.0000000000     85.78244
# 0.0001452289   0.0001452289     14.21756

```

#### Creazione tabella per i grafici
1. Definisco i vettori su cui costruirò la tabella
```{r, eval=F}
# Creo vettore classi
Classi <- c("Vegetazione + mare ", "Suolo esposto") # Creo vettore di testo usando le virgolette

# Creo vettore percentuali di Aprile
p_pre_fire <- c(90.9, 9.07)

# Creo vettore percentuali di Settembre
p_post_fire <- c(85.7, 14.2) 

```
2. Per costruire una tabella uso la funzione "data.frame()"
Nel nostro caso, il dataframe deve avere 3 colonne: "class", "p_pre_fire", "p_post_fire" 
```{r, eval=F}
tabout <- data.frame(Classi, p_pre_fire, p_post_fire)
tabout # Mi mostrerà la tabella
```
3. Costruisco i grafici usando la funzione "ggplot2()"
```{r, eval=F}
# Grafico Aprile
p1 <- ggplot(tabout, aes(x=Classi, y=Aprile, color=Classi)) + 
        geom_bar(stat="identity", fill="white") +
         labs(title="Pre incendio")
         
# Grafico Settembre
p2 <- ggplot(tabout, aes(x=Classi, y=Settembre, color=Classi)) + 
       geom_bar(stat="identity", fill="white") +
         labs(title="Post incendio")

# Plot finale
plot(p1 + p2)
```
>**ggplot**
```{r, eval=F}
La Funzione "aes()" specifica le caratteristiche visive del grafico: 
+ x= class ---> collega la variabile “class” all’asse x.
+ y= p_pre_fire ---> specifica la variabile sull'asse Y 
+ color=class ---> impostiamo il colore delle barre in base alla variabile "class" e assegna un colore diverso a ogni categoria

La funzione geom_bar():
+  stat="identity" indica che le altezze delle barre sono specificate direttamente dai dati;
+ geom_bar(fill="white"): indica il colore di riempimento delle barre, impostato su bianco

```

THE END
