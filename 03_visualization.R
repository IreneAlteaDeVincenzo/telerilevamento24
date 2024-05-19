# Visualizzare immagini da satellite tramite imageRy su R

# Prima di tutto devo caricare i pacchetti per usare imageRy
library(terra)
library(imageRy) # Ora potrò accedere alle funzioni e ai dati dentro imageRy

# NB: tutte le funzioni in imageRy cominciamo con "im." Nel pacchetto è presente un manuale con la lista di funzioni.

# Per conoscere i dati presenti nel pacchetto, possiamo usare la funzione "im.list()"
im.list() 

#----------------- IMPORTARE I DATI -----------------
# Importa dati da imageRy utilizzando la funzione "im.import()"

# Importa tutte le bande dell'immagine "sentinel.dolomites"
# IMPORTO BANDA BLU
b2 <- im.import("sentinel.dolomites.b2.tif") # In questo modo andiamo ad importare l'immagine raster associata 

# IMPORTO BANDA VERDE
b3 <- im.import("sentinel.dolomites.b3.tif")

# IMPORTO BANDA ROSSA
b4 <- im.import("sentinel.dolomites.b4.tif") 

#IMPORTO BANDA INFRAROSSO
b8 <- im.import("sentinel.dolomites.b8.tif")

# --------------- CAMBIARE SCALA COLORI --------------- 
# Qual'ora i colori dell'immagine non ci piacciano, possiamo cambiare scala di colori per fare il plot immagine. 
# La funzione "colorRampPalette()" ci permette di creare una tavolozza di colori personalizzata, con un numero specificato di gradazioni tra i colori
clg <- colorRampPalette(c("black", "grey", "light grey"))(3) # Utilizziamo "c()" per concatenare tutti i colori insieme. Aggiungiamo "(3)" per dire in numero di sfumature da usare ma, è meglio usarne (100)
plot(b2, col=clg) # Funzione plot(oggetto, col=palette colori)

# Altre scale di colori
clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(100)
plot(b2, col=clcyan)

cl <- colorRampPalette(c("magenta", "cyan4", "cyan", "blue"))(100)
plot(b2, col=cl)

#------------------CAMBIARE I COLORI PER PIGRI----------------
# Volendo, posso usare palette predefinite. Devo richiamare il pacchetto "viridis" e poi posso scegliere tra diverse palette prefedinite: "viridis", “magma”, “plasma”, “inferno", "cividis", "rocket", "mako", "turbo"
library("viridis")
plot(b2, col=magma(100))

#------------------------ MULTIFRAME ------------------------
# Se vogliamo visualizzare più immagini insieme per effettuare un confronto, possiamo: usare la funzione "par(mfrow=c(___))"

par(mfrow=c(2,2)) # Stiamo sostanzialmente costruendo una matrice 2x2, con le 4 immagini da noi caricate
plot(b2, col=clcyan)
plot(b3, col=clcyan)
plot(b4, col=clcyan)
plot(b8,col=clcyan) # in questo modo andremo a caricare le 4 immagini

#---Esempi di altre matrici che posso costruire---
# par(mfrow = c(4, 1)): Crea una griglia con 4 righe e 1 colonna
# par(mfrow = c(1, 4)): Crea una griglia con una singola riga e 4 colonne.

#-------------------------------------- STACK ----------------------------------
# Posso costruire un vettore con le 4 immagini che abbiamo creato, plottandole insieme così da ottenere una singola immagine satellitare
stacksent<-c(b2, b3, b4, b8) # Questa riga combina quattro strati raster (b2, b3, b4 e b8) in un unico oggetto
plot(stacksent, col=clcyan)

#--- PLOT SINGOLO ELEMENTO DELLO STACK---
#Se voglio lavorare su un singolo elemento dello stack, ad esemplio l'elemento 4 (b8), posso usare le parentesi quadrate [x]
plot(stacksent[[4]], col=clcyan) # "[]" Serve a richimare un solo elemente di un vettore. Tuttavia, visto che siamo in una matrice, ne devo usare due

# Usa dev.off() se vuoi cancellare il plot precedente

#------------------------ PLOT STACK RGB ------------------------
# Plottiamo i vari elementi dello stack sovrapposti, così da ottenere un'unica immagine satellitare (reale/multispettrale).
# Per farlo, usiamo la funzione "im.plotRGB(oggetto, R, G, B)"
# Questa funzione serve a creare 1 singola immagine a colori basata su tre strati, che rappresentano i canali Red, GREEN, BLUE. 

# L'elemento [[1]] dello stack corrisponde alla banda del Blue=b2
# L'elemento [[2]] dello stack corrisponde alla banda del Green=b3
# L'elemento [[3]] dello stack corrisponde alla banda del Red=b4
# L'elemento [[4]] dello stack corrisponde alla banda del infrarosso=b8

par(mfrow=c(2,2)) # In questo modo faccio un plot multiframe 2x2 
im.plotRGB(stacksent, 3, 2, 1) # Cosa significano i numeri? Scrivendo "3" in R, dico al programma di associare R al 3°elemento del vettore. Scrivendo "2" in G, associo G al 2°elemento vettore.
im.plotRGB(stacksent, 4, 2, 1) # In questo caso col numero "4" richiamo la banda infrarosso nella banda del RED
im.plotRGB(stacksent, 3, 4, 1) # Metto infrarosso nella banda del GREEN
im.plotRGB(stacksent, 3, 2, 4) # Mettendo infrarosso nella banda del BLU, vado a evidenziare il suolo nudo

#---INFORMAZIONI SULL'IMMAGINE---
# Per ottenere informazioni sull'immagine raster basta richiamarla.
# b2<-im.import("sentinel.dolomites.b82.tif")
# b2 --> uscità una lista con tutta una serie di valori.

#---------- STUDIARE CORRELAZIONE TRA VARIABILI ----------
# Usiamo la funzione "pairs()" che analizza il potenziale di correlazione tra variabili diverse, creando dei grafici e nel contempo calcolando l'indice di correlazione di Pearson
pairs(stacksent) 



