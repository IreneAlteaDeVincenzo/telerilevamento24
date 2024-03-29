# Visualizzare immagini da satellite tramite imageRy su R

#Prima di tutto devo caricare i pacchetti per usare imageRy
library(terra)
library(imageRy) #A questo punto posso usare ed accedere alle funzioni e ai dati dentro imageRy

# Per conoscere i dati presenti nel pacchetto, possiamo usare la funzione:
im.list() #NB:tutte le funzioni in imagery cominciamo con "im."Nel pacchetto è presente un manuale con la lista di funzioni.

# Importa dati da imagery
b2<- im.import("sentinel.dolomites.b2.tif") # in questo modo andiamo ad importare l'immagine raster associata 

#Qual'ora i colori dell'immagine non ci piacciano, possiamo scegliere e cambiare scala di colori per fare il plot immagine. 
#Per farlo, usiamo la funzione "colorRampPalette". Scegli la scala di colori e concatenali con la funzione "c()", che serve a costruire un vettore.
clg<-colorRampPalette(c("black", "grey", "light grey"))(3) #funzione "c()" serve a concatenare tutti i colori insieme. Aggiungiamo "(3)" per dire in numero di sfumature da usare, ma meglio usarne(100)

#Plottiamo i dati 
plot(b2, col=clg) #funzione plot(oggetto, col=palette colori)

#Proviamo di nuovo, usando un'altra scala di colori 
clcyan<-colorRampPalette(c("magenta", "cyan4", "cyan"))(100)
plot(b2, col=clcyan)

#SONO PIGRA. Volendo, posso usare palette predefinite. Devo richiamare il pacchetto "viridis" e poi posso scegliere tra 4 diverse palette prefedinite: "viridis" “magma”, “plasma”, and “inferno"
library("viridis")
plot(b2, col=magma(100))

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

#Multiframe, ci permette di combinare le immagini, visualizzandole tutte insieme per un eventuale confronto
par(mfrow=c(2,2)) #Stiamo sostanzialmente costruendo una matrice 2x2, con le 4 immagini da noi caricate, andando a combinare righe e colonne
plot(b2, col=clcyan)
plot(b3, col=clcyan)
plot(b4, col=clcyan)
plot(b8,col=clcyan) # in questo modo andremo a caricare le 4 immagini

#Volendo, posso cambiare la visualizzazione della matrice di immagini. Ad esempio, per visualizzarle in fila basta fare un vettore x=(1,4) --> vettore costituito da 1 riga, 4 colonne
par(mfrow=c(1,4)) 
plot(b2, col=clcyan)
plot(b3, col=clcyan)
plot(b4, col=clcyan)
plot(b8,col=clcyan) 

#Posso costruire un vettore con le 4 immagini che abbiamo creato, plottandole
stacksent<-c(b2, b3, b4, b8)
plot(stacksent, col=clcyan)

#Se voglio lavorare poi su un singolo elemento dello stack, ad esemplio l'elemento 4 (b8), posso usare le parentesi quadrate [x]
plot(stacksent[[4]], col=clcyan) #per richimare un solo elemente di un vettore, uso una []. tuttavia, visto che siamo in una matrice, ne devo usare due


#usa dev.off() se vuoi cancellare il plot precedente

#RGB PLOT
# L'elemento [[1]] dello stack corrisponde alla banda del Blue=b2
# L'elemento [[2]] dello stack corrisponde alla banda del Green=b3
# L'elemento [[3]] dello stack corrisponde alla banda del Red=b4
# L'elemento [[4]] dello stack corrisponde alla banda del infrarosso=b8
par(mfrow=c(2,2)) #in questo modo faccio un plot multiframe
im.plotRGB(stacksent, 3, 2, 1) #cosa significano i numeri? scrivendo "3" dico al programma di associare R=al terzo elemento. Scrivendo "2" associo G=al secondo elemento del vettore etc..
im.plotRGB(stacksent, 4, 2, 1) # in questo caso col numero 4 richiamo la banda infrarosso nella banda del Rosso
im.plotRGB(stacksent, 3, 4, 2) # metto l'infrerosso nella banda del Green
im.plotRGB(stacksent, 3, 2, 4) # mettendo l'infrarosso nella banda del Blu, vado a evidenziare il suolo nudo

#Per avere informazioni su ul'immabine raster, basta plottarla e poi richiamarla.
# b2<-im.import("sentinel.dolomites.b82.tif")
#b2 --> uscità una lista con tutta una serie di valori.

#Funzione PAIR() -->  va a studiare il potenziale di correlazione tra variabili diverse, calcolando nel contempo l'indice di correlazione di Pearson. 
pairs(stacksent) 



