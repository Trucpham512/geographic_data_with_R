#'---
#' title: Chap02 - Geographic data
#' author: ""
#' date: ""
#' output:
#'  github_document
#'---

#+ message=FALSE
# install.packages("spDataLarge",
#                  repos = "https://geocompr.r-universe.dev")
pacman::p_load(
  rio,            # import and export files
  here,           # locate files 
  tidyverse,      # data management and visualization
  skimr,
  sf,             # classes and functions for vector data
  terra,          # classes and functions for raster data
  spData         # load geographic data
)

#' # Vector data
# vector data #---------------------
#' ## `sf`: Simple feature
## sf #-----------
class(world)

names(world)

world

plot(world)

skimr::skim(world)

summary(world["lifeExp"])

world %>% 
  slice(1:2) %>% 
  select(1:3)

#' ## Basic map
## basic map #-----------
plot(world[3:6])

plot(world["pop"])

#' Add layers to existing map
(world_asia <- world %>% filter(continent == "Asia"))

(asia <- st_union(world_asia))

plot(world_asia["pop"])

plot(asia)

plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")

