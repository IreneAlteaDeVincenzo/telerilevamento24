# FIRST R SCRIPT

# ------------------ Utilizzare R come una calcolatrice ------------------ 
a <- 6 * 7  # Il simbolo <- assegna i valori (6*7) al vettore chiamato "a"
b <- 5 * 8
a+b # R eseguirà l'operazione somma, mostrandoci il risultato

# ARRAYS

# ------------------ CREARE UN VETTORE ------------------ 
flowers <-c(3, 6, 8, 10, 15, 18) # Questa riga di codice crea un vettore chiamato “flowers” contenente i seguenti valori: 3, 6, 8, 10, 15 e 18
flowers # Richiamando il vettore, posso vedere i numeri di cui è composto

insects <-c(0, 16, 25, 42, 61, 73)
insects

# Plottare i valori "flowers vs insects" in un grafico
plot(flowers, insects)

# AGGIUNTA MIA: inseriamo un titolo al grafico usando "main="
plot(flowers, insects, main="Flowers Vs Insects") 

# ------------------ CHANGING PLOT PARAMETERS ------------------ 

# Symbols shape
# Utilizzare l’argomento "pch" (plotting character) nella funzione plot()
plot(flowers, insects, pch=19) # pch=19 plotta "cerchi pieni"

# -----Altri simboli utilizzabili -----
# pch=15 quadrato pieno 
# pch=17 triangolo pieno
# pch=0 quadrato vuoto etc.

# Symbol dimension
# Utilizzare l’argomento "cex" (character expansion) nella funzione plot()
plot(flowers, insects, pch=19, cex=2) # Aumenta la dimensione dei punti x2
plot(flowers, insects, pch=19, cex=0.5) # Riduce la dimensione dei punti di 1/2

# Change color
# Utilizzare l'argomento "col=x" per cambiare il colore del plot
plot(flowers, insects, pch=19, cex=2, col="chocolate1") 

# -----Altri colori utilizzabili -----
# col="blue"
# col="green"
# col="red"
# col="purple" etc.

