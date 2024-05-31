# Telerilevamento24

This report is throught for remote sensing lecture at UNIBO🛰️

## Master programs involved

This course involves the following master programs:

+ Scienze e gestione della natura
+ Geologia e Territorio
+ BLA BLA

## Linguaggi utilizzati
+ bla
+ bla bla

>**Note**
> Bla bla bla

>**Warning**
> Non fumare mentre fai benzina

>**Link Unibo**
>[UNIBO] (https://corsi.unibo.it/magistrale/GeologiaTerritorio/orario-lezioni?anno=1&curricula=B59-000)

## Main bla bla
```{r}
libray(Terra)
```
## Doppio Main BLA BA

In this case you attain a result: 
```{r}
im.list()
```


## Per importare la funzione senza però visualizzare i dati fare:
```{r, eval=F}  
im.import("matogrossoblabla.jpg)
```

## Se vuoi scrivere la funzione e nel contempo visualizzare i dati 

In this case you attain a result: 
```{r, eval=T}
mato1992<-im.import("matogrosso_ast_2006209_lrg.jpg" )
```





  ## Plottare più immagini tutte insieme
```{r, eval=T}
par(mfrow=c(2,2))
m1<-im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato1992, r=2, g=1, b=3)
im.plotRGB(mato1992, r=3, g=2, b=1)
im.plotRGB(mato1992, r=1, g=3, b=1)
```

## Calcolare indici spettrali
```{r, eval=T}
library(terra)
library(viridis)
dvi <- mato1992[[1]]-mato1992[[2]]
plot(dvi, col=viridis(100))
```

## Calcolare indici spettrali
```{r, eval=T}
library(terra)
library(viridis)
dvi <- mato1992[[1]]-mato1992[[2]]
viridisc <- colorRampPalette(viridis(7))(255)
plot(dvi, col=viridisc)
```

## Calculating spatial variability
Calculating variability:
```{r, eval=T}
sd5 <- focal(mato1992[[1]], matrix(1/25, 5, 5), fun=sd)
plot(sd5, col=viridisc)
```
