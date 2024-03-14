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
plot(b3, col=clcyan)

#IMPORTO BANDA ROSSA
b4<- im.import("sentinel.dolomites.b4.tif") # in questo modo andiamo ad importare l'immagine raster associata 
plot(b4, col=clcyan)

#IMPORTO BANDA INFRAROSSO
b8<- im.import("sentinel.dolomites.b8.tif") # in questo modo andiamo ad importare l'immagine raster associata 
plot(b8,col=clcyan)

#multiframe, ci permette di combinare le immagini, visualizzandole tutte insieme per un eventuale confronto
par(mfrow=c(2,2)) #Stiamo sostanzialmente costruendo una matrice 2x2, con le 4 immagini da noi caricate, andando a combinare righe e colonne
plot(b2, col=clcyan)
plot(b3, col=clcyan)
plot(b4, col=clcyan)
plot(b8,col=clcyan) # in questo modo andremo a caricare le 4 immagini

#Volendo, posso cambiare la visualizzazione della matrice di immagini. Ad esempio, per visualizzarle in fila basta fare un vettore x=(1,4)
par(mfrow=c(1,4)) 
plot(b2, col=clcyan)
plot(b3, col=clcyan)
plot(b4, col=clcyan)
plot(b8,col=clcyan) 

#è possibile anche andare a combinare le 4 bande insieme, così da ottenere un'immagine satellitare completa, sovrapponendole.
#Per farlo, uso la funzione di "stack(x), ottenendo una simngola immagine satellitare
stacksent<-c(b2, b3, b4, b8)
plot(stacksent, col=clcyan)

#Se voglio valorare poi su un singolo elemento dello stack, ad esemplio l'elemento 4 (b8), posso usare le parentesi quadrate [x
plot(stacksent[[4]], col=clcyan)


#usa dev.off(x) se vluoi cancellare il plot precedente
