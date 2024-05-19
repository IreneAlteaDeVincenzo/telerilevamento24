#COME FARE ANALISI MULTIVARIATA

library(terra)
library(imageRy)
library(viridis) 

im.list()

# Importo immagine delle tofane delle Dolomiti, con le relative 4 bande
b2 <- im.import("sentinel.dolomites.b2.tif")  # Banda Blue =2
b3 <- im.import("sentinel.dolomites.b3.tif")  # Banda Green=3
b4 <- im.import("sentinel.dolomites.b4.tif")  # Banda Red=4
b8 <- im.import("sentinel.dolomites.b8.tif")  # Banda Nir=8

# Faccio lo stack tra tutte le 4 bande per comporre una singola immagine satellitare
stack<-c(b2, b3, b4, b8)
im.plotRGB.auto(stack)
im.plotRGB(stack, 3, 4, 2) # Plot NIR su Green

# Cacolare tutte le correlazioni tra le varie bande con la funsione pairs 
pairs(stack) #R, G, B, hanno in questo caso un buon potenziare di correlazione, la banda dell'infrarosso (NIR) un po' meno --> Indice di Pearson (1 = correlazione positiva, -1 = correlazione negativa)

# ------------------------ANALISI MULTIVARIATA PCA ---------------------
# L'analisi PCA (Principal Component Analysis) cerca di ridurre la multidimensionalità tipica dei sistemi naturali (ad esempio da 4D--> 2D)
# Per farlo la PCA costruisce un nuovo sistema di riferimento basato su due assi principali: PC1 e PC2 (prima e la seconda componente principale)
# Questi nuovi assi spiegano la maggior parte della varianza delle variabili rappresentate lungo gli assi. 

# Su R, possiamo effettuare un'analisi multivariata PCA usando la funzione "im.pca()" --> funzione che compatta il set in poche dimensioni e restituisce le componenti PC1, PC2 
pcimage <-im.pca(stack)

#Ti uscità una griglia di valori:
#Standard deviations (1, .., p=4):
#[1] 1726.41823  501.01429   68.21149   27.09133 ----> Questi valori ti serviranno più avanti
#
#Rotation (n x k) = (4 x 4):
#                            PC1        PC2         PC3         PC4
#sentinel.dolomites.b2 0.4091898  0.2633750 -0.73691553  0.46920442
#sentinel.dolomites.b3 0.4667633  0.2105509 -0.19777933 -0.83587300
#sentinel.dolomites.b4 0.5987034  0.3829932  0.64625928  0.27788384
#sentinel.dolomites.b8 0.5062114 -0.8600106  0.01370347  0.06280215

# Plot 
plot(pcimage, col=viridis(100))

# Per conoscere la variabilità esplicata dal primo asse PC1, posso calcolare i valori di standard deviation e fare la somma 
tot<-sum(1554.35604,  505.76984,   45.39869,   32.62567) # Sommo i valori di deviazione standard
1554.35604*100/tot # Mi uscità un valore, ad esempio 72% che mi dice la variabilità rappresentata dal primo asse PC1
