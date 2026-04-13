library(ncdf4)
library(ggplot2)


nc_data <- nc_open("short-dataset.nc")
# Extract the variables

temperature <- ncvar_get(nc_data, "thetao")
raw_time <- ncvar_get(nc_data, "time")
t_units <- ncatt_get(nc_data, "time", "units")
actual_dates <- as.POSIXct(raw_time, origin = "1970-01-01", tz = "UTC")
lons <- ncvar_get(nc_data, "longitude")
lats <- ncvar_get(nc_data, "latitude")

# See time series at random location
plot(actual_dates, temperature[1, 1, ], type = "l", xlab = "Time", ylab = "Temperature (°C)", main = "Temperature Time Series")



# See map at random time point at all locations
time_idx <- 1000 
temp_time <- temperature[,,time_idx] 
temp_df <- expand.grid(lon = lons, lat = lats) 
temp_df$temp <- as.vector(temp_time)
ggplot(temp_df, aes(x = lon, y = lat, fill = temp)) +
  geom_tile(
    width = 0.01, height = 0.01   # much smaller than grid spacing
  ) +
  scale_fill_viridis_c(na.value = "transparent") +
  coord_fixed() +
  theme_minimal()



