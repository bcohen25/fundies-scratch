use context dcic2024
include csv
include data-source
workout = table: date :: String, activity :: String, duration :: Number
  row: "2025-04-01", "Running", 30
  row: "2025-05-30", "Outdoor Walk", 90
end
workout

workout.row-n(0)
workout.row-n(1)["activity"]
recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/recipes.csv", default-options)
    sanitize servings using num-sanitizer
end
recipes

plant-sightings = load-table: plant_common_name :: String, location_latitude :: Number, location_longitude :: Number, date_sighted :: String, soil_type :: String, plant_height_cm :: Number, plant_color :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
end

plant-sightings.row-n(50)
plant-sightings.length()
plant-sightings.row-n(10)["soil_type"]
plant-sightings.row-n(10)["country"]
glucose-levels= load-table: patient_id :: Number,glucose_level :: Number,date_time :: Number,insulin_dose :: Number,exercise_duration :: Number,stress_level :: Number
  source: csv-table-file("glucose_levels.csv", default-options)
  sanitize glucose_level using num-sanitizer
end


mean(glucose-levels, "exercise_duration")

exercise_duration_and_stress_levels=scatter-plot(glucose-levels, glucose-levels["exercise_duration"], glucose-levels["stress_level"])
exercise_duration_and_stress_levels