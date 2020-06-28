##########################################################################
# Obtendo as malhas dos municípios do RJ e dos bairros do RJ
##########################################################################

#ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/

#download.file("http://servicodados.ibge.gov.br/Download/Download.ashx?u=geoftp.ibge.gov.br/cartas_e_mapas/bases_cartograficas_continuas/bc25/rj/versao2016/shapefile/lim.zip", "./dados/lim.zip")

library(rgdal)
library(sf)
library(leaflet)
library(plotly)
library(ggplot2)

MunicipiosRJ <- readOGR(dsn = "./Data/rj_municipios", layer = "RJ_MUNICIPIOS_2017_CENSOAGRO", encoding="UTF-8", use_iconv=TRUE) 
#Perceba que deve-se informar o path ao arquivo shp separado do nome do arquivo e este ultimo, deve ser informado omitindo a extensão (".shp")
ogrInfo("./Data/rj_municipios", "RJ_MUNICIPIOS_2017_CENSOAGRO") #Informações do Shape File

head(MunicipiosRJ@data)
plot(MunicipiosRJ)

#Obter o CRS no comando anterior e tranformar para um padrão que o leaflet interprete corretamente
shapeData <- spTransform(MunicipiosRJ, CRS("+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs"))
leaflet() %>%
  addTiles() %>%
  addPolygons(data = shapeData,
              weight = 1,
              col = 'blue',
              fillOpacity = 0.1)




shp <- read_sf('./Data/rj_municipios/RJ_MUNICIPIOS_2017_CENSOAGRO.shp')
ggplot(shp) + geom_sf()


a1 <- ggplotly(
  ggplot(shp) +
    geom_sf(aes(fill = NOME))
) 

a1

###############################
BairrosRJ <- readOGR(dsn = "./Data/Limite_de_Bairros-shp", layer = "Limite_de_Bairros", encoding="UTF-8", use_iconv=TRUE) 
head(BairrosRJ@data)
plot(BairrosRJ)


ogrInfo("./Data/Limite_de_Bairros-shp", "Limite_de_Bairros") #Informações do Shape File



shapeData <- spTransform(BairrosRJ, CRS("+proj=utm +zone=23 +south +ellps=aust_SA +towgs84=-66.87,4.37,-38.52,0,0,0,0 +units=m +no_defs"))
leaflet() %>%
  addTiles() %>%
  addPolygons(data = shapeData,
              weight = 1,
              col = 'blue',
              fillOpacity = 0.1)


shp <- read_sf('./Data/Limite_de_Bairros-shp/Limite_de_Bairros.shp')
ggplot(shp) + geom_sf()


a1 <- ggplotly(
  ggplot(shp) +
    geom_sf()
) 

a1


#######################

ggplot() + 
  geom_sf(data = lad, colour = "light gray", fill = NA) +
  geom_sf(data = reg, colour = "dark gray", fill = NA)