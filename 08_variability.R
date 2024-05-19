# Misuro la variabilità di un'immagine satellitare

library(imageRy)
library(terra)
library(viridis)

im.list()

# Carico l'immagine di Sentinel 2
sent <- im.import("sentinel.png")

# Plot

# Bande
# 1= NIR
# 2= RED
# 3= GREEN

im.plotRGB(sent, 1, 2, 3)
im.plotRGB(sent, r=2, g=1, b=3) # Nir su Green

#--------------- CALCOLARE VARIABILITA' IMMAGINE--------------- 
# METODO "MOVING WINDOW": ci consente di calcolare la variabilità di un’immagine in R. 

# Principio di funzionamento:
#1. Definisci una finestra mobile: ossia, la regione dell’immagine su cui calcolerai la variabilità. La matrice(1/9, 3, 3) è una matrice 3x3; 1/9 è l'unità della matrice/ il valore costante per ogni cella 
#2. Muovi la finestra su tutta l’immagine, calcolando la variabilità all’interno di ciascuna finestra: usa funzione "focal()", che calcola la “moving window”
#3. Calcola  la deviazione standard dei valori dei pixel all’interno  di goni finestra usando la funzione "sd()". "fun=sd" --> indico che la funzione che voglio utilizzare è la deviazione standard

# NB: Posso calcolare la variabilità per una singola banda: in questo esercizio uso la banda NIR

nir <- sent[[1]] # Associo la banda 1 adell'immagine all'oggetto chiamato "nir"
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # Calcola la deviazione standard su una finestra mobile dell’immagine nella banda 1 
plot(sd3)

# Plot con viridis
# è lo stesso pacchetto che usi sempre, ma a quanto pare le palettes sono i daltonici. Nice.
plot(sd3, col=viridis(100))

# Deviazione Standard di una matrice 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd) # Unità matrice varia con la dimenzione della matrice. In questo caso è 7x7=49 --> unità matrice=1/49 
plot(sd7, col=viridis(100))

# Deviazione standard di una matrice 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd) # Unità matrice varia con la dimenzione della matrice. In questo caso è 13x13=169 --> unità matrice= 1/169
plot(sd13, col=viridis(100))

# stack
stacksd <- c(sd3, sd7)
plot(stacksd, col=viridisc)

# Standard deviation 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)

# Stack delle 3 immagini
stack <- c(sd3, sd7, sd13)
plot(stack, col=viridis(100))
