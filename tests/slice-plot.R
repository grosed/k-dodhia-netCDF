library(ncdf4)
library(ggplot2)

# ---- User settings ----
nc_file <- "data.nc"   # <-- change this
varname <- "thetao"          
t_index <- 1           # <-- choose the time slice index you want

# ---- Open netCDF ----
nc <- nc_open(nc_file)

# ---- Read coordinate variables ----
lon <- ncvar_get(nc, "longitude")
lat <- ncvar_get(nc, "latitude")
time <- ncvar_get(nc, "time")


vals <- ncvar_get(nc,
		  varname,
  		  start = c(1, 1, t_index),   # lon, lat, time
  		  count = c(-1, -1, 1)        # all lon, all lat, one time step
)

## close the netCDF file
nc_close(nc)

vals <- drop(vals)

df <- expand.grid(lon = lon, lat = lat)
df$value <- as.vector(vals)

# ---- Plot ----
ggplot(df, aes(x = lon, y = lat, fill = value)) +
  geom_raster() +
  coord_equal(expand = FALSE) +
  scale_fill_viridis_c(na.value = "transparent") +
  labs(
    title = paste("Time slice", t_index),
    x = "Longitude",
    y = "Latitude",
    fill = varname
  ) +
  theme_minimal()

