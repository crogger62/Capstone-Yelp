# 
#  Server.R
#
# Load lots of libraries

library(jsonlite)
library(UsingR)
library(leaflet)
library(maps)

# Read pre-processed data
#
bizrates<-read.table("bizrates.dat")
                     

shinyServer(
    
    function(input, output) {
      
      output$map <-renderLeaflet({      
         
          # for ranges
          lower<-1
          upper<-5
          # We will keep bizrates as our reference version of the data and filter into the Sbizrates variable
          
          Sbizrates = bizrates   
        
# filter takeout only 
    if (input$takeout)
        wo <- (Sbizrates$biz_rest.attributes..Take.out. == TRUE)
    else
        wo <- (Sbizrates$biz_rest.attributes..Take.out. == FALSE)
      Sbizrates<-Sbizrates[wo,]
      
# filter Reservations only 
      
      if (input$reserve)
          wo <- (Sbizrates$biz_rest.attributes..Takes.Reservations. == TRUE)
      else
          wo <- (Sbizrates$biz_rest.attributes..Takes.Reservations. == FALSE)
      Sbizrates<-Sbizrates[wo,]
      
# filter WiFi only 
      
      if (input$wifi)
          wo <- (Sbizrates$biz_rest.attributes..Wi.Fi. == "free")
      else
          wo <- (Sbizrates$biz_rest.attributes..Wi.Fi. == FALSE)
      Sbizrates<-Sbizrates[wo,]
      
  
# filter Caters only 
      
      if (input$caters)
          wo <- (Sbizrates$biz_rest.attributes.Caters == TRUE)
      else
          wo <- (Sbizrates$biz_rest.attributes.Caters == FALSE)
      Sbizrates<-Sbizrates[wo,]
      
# filter on stars
      lower<-as.numeric(input$stars[1])
      wo <- Sbizrates$biz_rest.stars >= lower
      Sbizrates<-Sbizrates[wo,]
      
      
      upper<-as.numeric(input$stars[2])
      wo <- Sbizrates$biz_rest.stars <= upper
      
      Sbizrates<-Sbizrates[wo,]
      
# generate map        
        mymap<-leaflet() %>% 
            addTiles() %>% 
            addTiles(urlTemplate = "http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png")  %>%  
            mapOptions(zoomToLimits="always") %>%             

            addMarkers(lat=Sbizrates$biz_rest.latitude,lng=Sbizrates$biz_rest.longitude,
                       clusterOptions = markerClusterOptions(),popup=Sbizrates$biz_rest.business_id) 
        
        mymap
      })
    
    }
)


