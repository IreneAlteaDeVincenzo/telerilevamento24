# First R script
#R as a calculator
a <- 6*7
b <- 5*8

a+b




# Arrays

flowers <-c(3, 6, 8, 10, 15, 18)
flowers

insects <-c(0, 16, 25, 42, 61, 73)
insects
#ora andiamo a mettere in relazione i nostri numeri plottando flowers vs insects in un grafico
#per fare questo esiste una funzione chiamata plot(x)

plot(flowers, insects)

#CHANGING PLOT PARAMETERS

#symbols shape
plot(flowers, insects, pch=19)

#symbol dimension
plot(flowers, insects, pch=19, cex=2) #con cex=2 avrò i simboli che saranno il doppio di quelli originali. se vuoi ridurne le dimensioni utilizza cex=.5 (che è uguale a 0.5)

#color
plot(flowers, insects, pch=19, cex=2, col="chocolate1") #funzione col=x per scegliere colore plot


