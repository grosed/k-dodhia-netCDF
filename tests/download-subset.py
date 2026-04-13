import copernicusmarine

copernicusmarine.subset(
  dataset_id="cmems_mod_ibi_phy-temp_my_0.027deg_PT1H-m",
  variables=["thetao"],
  minimum_longitude=-7,
  maximum_longitude=3,
  minimum_latitude=49,
  maximum_latitude=56,
  # start_datetime="1993-01-01T23:00:00",
  start_datetime="2024-01-01T23:00:00",
  end_datetime="2025-10-28T23:00:00"
)



