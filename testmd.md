Chap02 - Geographic data
================

``` r
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
```

# Vector data

``` r
# vector data #---------------------
```

## `sf`: Simple feature

``` r
## sf #-----------
class(world)
```

    ## [1] "sf"         "tbl_df"     "tbl"        "data.frame"

``` r
names(world)
```

    ##  [1] "iso_a2"    "name_long" "continent" "region_un" "subregion" "type"      "area_km2" 
    ##  [8] "pop"       "lifeExp"   "gdpPercap" "geom"

``` r
world
```

    ## Simple feature collection with 177 features and 10 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: -180 ymin: -89.9 xmax: 180 ymax: 83.64513
    ## Geodetic CRS:  WGS 84
    ## # A tibble: 177 × 11
    ##    iso_a2 name_long        continent   region_un subregion type  area_km2     pop lifeExp gdpPercap
    ##  * <chr>  <chr>            <chr>       <chr>     <chr>     <chr>    <dbl>   <dbl>   <dbl>     <dbl>
    ##  1 FJ     Fiji             Oceania     Oceania   Melanesia Sove…   1.93e4  8.86e5    70.0     8222.
    ##  2 TZ     Tanzania         Africa      Africa    Eastern … Sove…   9.33e5  5.22e7    64.2     2402.
    ##  3 EH     Western Sahara   Africa      Africa    Northern… Inde…   9.63e4 NA         NA         NA 
    ##  4 CA     Canada           North Amer… Americas  Northern… Sove…   1.00e7  3.55e7    82.0    43079.
    ##  5 US     United States    North Amer… Americas  Northern… Coun…   9.51e6  3.19e8    78.8    51922.
    ##  6 KZ     Kazakhstan       Asia        Asia      Central … Sove…   2.73e6  1.73e7    71.6    23587.
    ##  7 UZ     Uzbekistan       Asia        Asia      Central … Sove…   4.61e5  3.08e7    71.0     5371.
    ##  8 PG     Papua New Guinea Oceania     Oceania   Melanesia Sove…   4.65e5  7.76e6    65.2     3709.
    ##  9 ID     Indonesia        Asia        Asia      South-Ea… Sove…   1.82e6  2.55e8    68.9    10003.
    ## 10 AR     Argentina        South Amer… Americas  South Am… Sove…   2.78e6  4.30e7    76.3    18798.
    ## # ℹ 167 more rows
    ## # ℹ 1 more variable: geom <MULTIPOLYGON [°]>

``` r
plot(world)
```

    ## Warning: plotting the first 9 out of 10 attributes; use max.plot = 10 to plot all

![](testmd_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
skimr::skim(world)
```

    ## Warning: Couldn't find skimmers for class: sfc_MULTIPOLYGON, sfc; No user-defined `sfl` provided.
    ## Falling back to `character`.

|                                                  |       |
|:-------------------------------------------------|:------|
| Name                                             | world |
| Number of rows                                   | 177   |
| Number of columns                                | 11    |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |       |
| Column type frequency:                           |       |
| character                                        | 7     |
| numeric                                          | 4     |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |       |
| Group variables                                  | None  |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min |   max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|------:|------:|---------:|-----------:|
| iso_a2        |         2 |          0.99 |   2 |     2 |     0 |      175 |          0 |
| name_long     |         0 |          1.00 |   4 |    35 |     0 |      177 |          0 |
| continent     |         0 |          1.00 |   4 |    23 |     0 |        8 |          0 |
| region_un     |         0 |          1.00 |   4 |    23 |     0 |        7 |          0 |
| subregion     |         0 |          1.00 |   9 |    25 |     0 |       22 |          0 |
| type          |         0 |          1.00 |   7 |    17 |     0 |        5 |          0 |
| geom          |         0 |          1.00 | 135 | 24760 |     0 |      177 |          0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate | mean | sd | p0 | p25 | p50 | p75 | p100 | hist |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|:---|
| area_km2 | 0 | 1.00 | 832558.33 | 2163425.48 | 2416.87 | 46185.25 | 185004.13 | 621860.35 | 1.701851e+07 | ▇▁▁▁▁ |
| pop | 10 | 0.94 | 42815798.06 | 149413217\.06 | 56295.00 | 3754725.00 | 10401062.00 | 30748039.00 | 1.364270e+09 | ▇▁▁▁▁ |
| lifeExp | 10 | 0.94 | 70.85 | 8.21 | 50.62 | 64.96 | 72.87 | 76.78 | 8.359000e+01 | ▂▃▅▇▅ |
| gdpPercap | 17 | 0.90 | 17105.99 | 18668.07 | 597.14 | 3752.37 | 10734.07 | 24232.74 | 1.208601e+05 | ▇▂▁▁▁ |

``` r
summary(world["lifeExp"])
```

    ##     lifeExp                 geom    
    ##  Min.   :50.62   MULTIPOLYGON :177  
    ##  1st Qu.:64.96   epsg:4326    :  0  
    ##  Median :72.87   +proj=long...:  0  
    ##  Mean   :70.85                      
    ##  3rd Qu.:76.78                      
    ##  Max.   :83.59                      
    ##  NA's   :10

``` r
world %>% 
  slice(1:2) %>% 
  select(1:3)
```

    ## Simple feature collection with 2 features and 3 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: -180 ymin: -18.28799 xmax: 180 ymax: -0.95
    ## Geodetic CRS:  WGS 84
    ## # A tibble: 2 × 4
    ##   iso_a2 name_long continent                                                                   geom
    ##   <chr>  <chr>     <chr>                                                         <MULTIPOLYGON [°]>
    ## 1 FJ     Fiji      Oceania   (((-180 -16.55522, -179.9174 -16.50178, -179.7933 -16.02088, -180 -16…
    ## 2 TZ     Tanzania  Africa    (((33.90371 -0.95, 31.86617 -1.02736, 30.76986 -1.01455, 30.4191 -1.1…

## Basic map

``` r
## basic map #-----------
plot(world[3:6])
```

![](testmd_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
plot(world["pop"])
```

![](testmd_files/figure-gfm/unnamed-chunk-4-2.png)<!-- -->

Add layers to existing map

``` r
(world_asia <- world %>% filter(continent == "Asia"))
```

    ## Simple feature collection with 47 features and 10 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: 26.04335 ymin: -10.35999 xmax: 145.5431 ymax: 55.38525
    ## Geodetic CRS:  WGS 84
    ## # A tibble: 47 × 11
    ##    iso_a2 name_long           continent region_un subregion type  area_km2    pop lifeExp gdpPercap
    ##  * <chr>  <chr>               <chr>     <chr>     <chr>     <chr>    <dbl>  <dbl>   <dbl>     <dbl>
    ##  1 KZ     Kazakhstan          Asia      Asia      Central … Sove… 2729811. 1.73e7    71.6    23587.
    ##  2 UZ     Uzbekistan          Asia      Asia      Central … Sove…  461410. 3.08e7    71.0     5371.
    ##  3 ID     Indonesia           Asia      Asia      South-Ea… Sove… 1819251. 2.55e8    68.9    10003.
    ##  4 TL     Timor-Leste         Asia      Asia      South-Ea… Sove…   14715. 1.21e6    68.3     6263.
    ##  5 IL     Israel              Asia      Asia      Western … Coun…   22991. 8.22e6    82.2    31702.
    ##  6 LB     Lebanon             Asia      Asia      Western … Sove…   10099. 5.60e6    79.2    13831.
    ##  7 PS     Palestine           Asia      Asia      Western … Disp…    5037. 4.29e6    73.1     4320.
    ##  8 JO     Jordan              Asia      Asia      Western … Sove…   89207. 8.81e6    74.0     8622.
    ##  9 AE     United Arab Emirat… Asia      Asia      Western … Sove…   79881. 9.07e6    76.9    63943.
    ## 10 QA     Qatar               Asia      Asia      Western … Sove…   11328. 2.37e6    77.9   120860.
    ## # ℹ 37 more rows
    ## # ℹ 1 more variable: geom <MULTIPOLYGON [°]>

``` r
(asia <- st_union(world_asia))
```

    ## Geometry set for 1 feature 
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: 26.04335 ymin: -10.35999 xmax: 145.5431 ymax: 55.38525
    ## Geodetic CRS:  WGS 84

    ## MULTIPOLYGON (((36.14976 35.82153, 35.90502 35....

``` r
plot(world_asia["pop"])
```

![](testmd_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
plot(asia)
```

![](testmd_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")
```

![](testmd_files/figure-gfm/unnamed-chunk-5-3.png)<!-- -->
