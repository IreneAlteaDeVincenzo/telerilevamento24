# Visualizzare immagini da satellite tramite imageRy su R

library(terra)
library(imageRy) #carichiamo i dati

# List of data avialable in imageRy
im.list() #tutte le immagini in imagery cominciamo con im. 

# Importa dati da imagery
b2<- im.import("sentinel.dolomites.b2.tif") # in questo modo andiamo ad importare l'immagine raster associata 

#A questo punto, possiamo andare a cambiare la scala di colori. Per farlo, usiamo la funzione "colorRampPalette". scegli la scala di colori e concatenali con la funzione "c"
clg<-colorRampPalette(c("black", "grey", "light grey"))(3) # funzione "c(x)" serve a concatenare tutti i colori insieme. Aggiungiamo "(3)" per dire in lunero di sfumature da usare, ma meglio usarne anche (100)

#Plottiamo i dati 
plot(b2, col=clg)

#Proviamo di nuovo, usando un'altra scala di colori 
clcyan<-colorRampPalette(c("magenta", "cyan4", "cyan"))(100)
plot(b2, col=clcyan)

#Importa anche bande aggiuntive. 
#IMPORTO BANDA VERDE
b3<- im.import("sentinel.dolomites.b3.tif") # in questo modo andiamo ad importare l'immagine raster associata 
plot(b3)

#IMPORTO BANDA ROSSA
b4<- im.import("sentinel.dolomites.b4.tif") # in questo modo andiamo ad importare l'immagine raster associata 
plot(b4, col=clcyan)

#IMPORTO BANDA INFRAROSSO
b8<- im.import("sentinel.dolomites.b8.tif") # in questo modo andiamo ad importare l'immagine raster associata 
plot(b8,col=clcyan)
