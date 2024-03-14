# Visualizzare immagini da satellite tramite imageRy su R

library(terra)
library(imageRy)

# List of data avialable in imageRy
im.list()

# Importa dati
mato <- im.import("matogrosso_ast_2006209_lrg.jpg")
