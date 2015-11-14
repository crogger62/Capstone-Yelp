Interactive Restaurant Shiny Application using Yelp Data
========================================================
author: C. Lewis
date: 15-November-2015
autosize: true

Objective: Using the Yelp Dataset Challenge, construct a Shiny application that allows users to search for restaurants with specific amenities and a range of review ratings (stars). Display the resulting search on a map the can be zoomed and panned.
- Read and process data set
- Construct data set suitable for mapping
- Display map using Leaflet
- Build Shiny application for interactive searching


Methods & Data - Preprocessing
========================================================

The first step is to read and process the JSON data. 
- Focus on the business reviews data set.
- Evaluated types of businesses and selected Restaurants as the source of data for the application.

The second step is to create a subset of data that will be used for the shiny application: 
- Identified criteria for searching in shiny application:
    + Business identification - Anonymized name of restaurant
    + Latitude & Longitude - geographical location of restaurant 
    + Stars - average review of restaurant
    + Take-out - does the restaurant offer to-go food.
    + Takes Reservations- does the restaurant accept reservations
    + Wi-fi - does the restaurant offer free wi-fi
    + Catering - does the restaurant have catering services

Finally, the pre-processed data is saved off to a file for use in the Shiny application to facilitate fast rendering of the map.  

Mapping Data
========================================================

Leaflet is JavaScript library that works as an add-on to R and allows for the development of interactive maps. 
- Leaflet handles selecting the underlying map and provides for zooming and panning automatically.
- Developer specifies latitude and longitude of locations of interest (i.e, restaurants) and an what should "pop-up" when a users clicks on an icon on the map (i.e., the business id)



```r
library(leaflet,quietly=TRUE)
library(maps,quietly=TRUE)

    # Read pre-processed data
    bizrates<-read.table("bizrates.dat")
    
    # Build out a leaflet object
    mymap<-leaflet() %>% 
        addTiles() %>% 
        addTiles(urlTemplate = "http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png")  %>%  
        mapOptions(zoomToLimits="always") %>%             
        addMarkers(lat=bizrates$biz_rest.latitude,lng=bizrates$biz_rest.longitude,
                       clusterOptions = markerClusterOptions(),popup=bizrates$biz_rest.business_id) 

    # And display it
    mymap
```
Unfortunately it does not render in RPresentation slides (see the HTML in github to see it in action; image is on next page). The report developed in association with his presentation has a live working version of the map. 

More on leaflet can be found here: **https://rstudio.github.io/leaflet/**

Shiny Application 
========================================================

<img src="ShinyPic.png"/>


User can select:
- Number of stars 
- Attributes for Take-out, Reservations, Wi-Fi and Catering.
- Leaflet handles map presentation and interaction


Summary
========================================================
- It works!
    + See companion report for working version of map. 
    + UI.R/Server.R and preprocessed data available at "https://github.com/crogger62/Capstone-Yelp""
- Can easily add additional searchable parameters found in the Yelp businesses review file for finer grained search parameters.
- Could broaden data set to include other food establishments as well. 
- Alternate business groupings, e.g., care repair. 
- Requires: 
    + Preprocessing of data to broaden or refocus search parameters.
    + Reconfigure Shiny application display to accommodate search parameters
