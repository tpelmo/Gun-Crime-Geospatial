install.packages("ggplot2")
install.packages("leaflet")
install.packages("sf")

install.packages("readxl") # Install the package
library(readxl)
data <- read_excel("Downloads/Data Analyst ONS/Example Data Set.xlsx")

# Define color mapping for crime types
crime_type_colors <- colorFactor(
  palette = c("darkblue", "darkorange", "darkgreen"), 
  levels = c("Aggravated Assault", "Robbery", "Homicide")  # Ensure these match exactly with the data
)

# Create the leaflet map
crime_map <- leaflet(data) %>%
  addTiles() %>%  # Add default OpenStreetMap tiles
  addCircleMarkers(
    ~Longitude, ~Latitude,
    color = ~crime_type_colors(`Crime Type`),  # Apply the color mapping
    popup = ~paste(
      "Crime Type:", `Crime Type`, "<br>",
      "Date:", `Date`, "<br>",
      "Time:", `Time`, "<br>",
      "Neighborhood:", `Neighborhood Name`, "<br>",
      "Victim Age:", `Victim Age`, "<br>",
      "Victim Gender:", `Victim Gender`, "<br>",
      "Victim Race:", `Victim Race`, "<br>",
      "Offender Age:", `Offender Age`, "<br>",
      "Offender Gender:", `Offender Gender`, "<br>",
      "Offender Race:", `Offender Race`
    ),
    radius = 5,
    fill = TRUE,
    fillOpacity = 0.7
  ) %>%
  addLegend(
    "bottomright",
    pal = crime_type_colors,
    values = ~`Crime Type`,
    title = "Crime Types",
    opacity = 1
  )

# View the map
crime_map

# Define color mapping for neighborhood classifications
crime_intensity <- colorFactor(
  palette = c("darkred", "red", "yellow"), 
  levels = c("High Crime", "Moderate Crime", "Low Crime")  # Ensure these match exactly with the data
)

# Create the leaflet map
neig_crime_intensity <- leaflet(data) %>%
  addTiles() %>%  # Add default OpenStreetMap tiles
  addCircleMarkers(
    ~Longitude, ~Latitude,
    color = ~crime_intensity(`Neighborhood Classification`),  # Apply the color mapping
    popup = ~paste(
      "Neighborhood Classification:", `Neighborhood Classification`, "<br>",
      "Qualified Census Tract:", `Qualified Census Tract`, "<br>",
      "Neighborhood:", `Neighborhood Name`, "<br>",
      "Crime Type:", `Crime Type`, "<br>",
      "Victim Age:", `Victim Age`, "<br>",
      "Victim Gender:", `Victim Gender`, "<br>",
      "Victim Race:", `Victim Race`, "<br>",
      "Offender Age:", `Offender Age`, "<br>",
      "Offender Gender:", `Offender Gender`, "<br>",
      "Offender Race:", `Offender Race`
    ),
    radius = 5,
    fill = TRUE,
    fillOpacity = 0.7
  ) %>%
  addLegend(
    "bottomright",
    pal = crime_intensity,
    values = ~`Neighborhood Classification`,
    title = "Neighborhood Classification",
    opacity = 1
  )

# View the map
neig_crime_intensity
