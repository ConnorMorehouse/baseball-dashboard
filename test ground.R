#####
# packages #
#####
library(shiny)
library(shinydashboard)
library(tidyverse)
library(baseballr)
library(shinyjs)
library(ggpubr)
library(data.table)

#####
# functions 
#####




#####
# run data import job 2019 #
#####

# 2015 #
rstudioapi::jobRunScript(path = '2015_gamepk_loop.R',
                         name = 'gamepk loop',
                         exportEnv = 'R_GlobalEnv')

write_csv(pbp_2019_df, 'pbp_2015.csv')

pbp_2015_df <- fread('pbp_2015.csv')

# 2016 #
rstudioapi::jobRunScript(path = '2016_gamepk_loop.R',
                         name = 'gamepk loop',
                         exportEnv = 'R_GlobalEnv')

write_csv(pbp_2016_df, 'pbp_2016.csv')

pbp_2016_df <- fread('pbp_2016.csv')

# 2017 #
rstudioapi::jobRunScript(path = '2017_gamepk_loop.R',
                         name = 'gamepk loop',
                         exportEnv = 'R_GlobalEnv')

write_csv(pbp_2017_df, 'pbp_2017.csv')

pbp_2017_df <- fread('pbp_2017.csv')

# 2018 #
rstudioapi::jobRunScript(path = '2018_gamepk_loop.R',
                         name = 'gamepk loop',
                         exportEnv = 'R_GlobalEnv')

write_csv(pbp_2018_df, 'pbp_2018.csv')

pbp_2018_df <- fread('pbp_2018.csv')

# 2019 #
rstudioapi::jobRunScript(path = '2019_gamepk_loop.R',
                         name = 'gamepk loop',
                         exportEnv = 'R_GlobalEnv')

write_csv(pbp_2019_df, 'pbp_2019.csv')

pbp_2019_df <- fread('pbp_2019.csv')

# 2020 #
rstudioapi::jobRunScript(path = '2020_gamepk_loop.R',
                         name = 'gamepk loop',
                         exportEnv = 'R_GlobalEnv')

write_csv(pbp_2020_df, 'pbp_2020.csv')

pbp_2020_df <- fread('pbp_2020.csv')

# 2021 #
rstudioapi::jobRunScript(path = '2021_gamepk_loop.R',
                         name = 'gamepk loop',
                         exportEnv = 'R_GlobalEnv')

write_csv(pbp_2021_df, 'pbp_2021.csv')

pbp_2021_df <- fread('pbp_2021.csv')



#####
# test plots # 
#####

{
inputmin <- 0
inputmax <- 45
test <- 0

testplot <- pbp_2020_df %>% 
  filter(matchup.batter.fullName == 'Juan Soto' & last.pitch.of.ab == T) %>% 
  ggplot(aes(x = hitData.launchAngle)) +
  geom_density() +
  lims(x = c(max(inputmin,range(pbp_2020_df$hitData.launchAngle, na.rm = T)[1])
             ,min(inputmax,range(pbp_2020_df$hitData.launchAngle, na.rm = T)[2])))
testplot
}

#####
# hitter/pitcher matchup #
#####

# inputs: hitter, pitcher, hitter/pitcher/matchup, woba/sws

{
hitter <- 'Juan Soto'
pitcher <- 'Clayton Kershaw'

hpm <- 'hitter'


uh <- pbp_2020_df %>% 
  filter(matchup.batter.fullName == hitter & matchup.pitcher.fullName == pitcher) #%>% 
  ggplot(aes(x = pitchData.coordinates.pX, y = pitchData.coordinates.pZ)) +
  geom_point()


}

js20 <- pbp_2020_df %>% 
  filter(matchup.batter.fullName == hitter)

sz <- data.frame(pitchData.coordinates.pX = c(-.708, .708, .708, -.708),
                 pitchData.coordinates.pZ = c(js20$pitchData.strikeZoneTop[1],
                                              js20$pitchData.strikeZoneTop[1],
                                              js20$pitchData.strikeZoneBottom[1],
                                              js20$pitchData.strikeZoneBottom[1]))

counts <- list(c(0,0),c(0,1),c(0,2),
            c(1,0),c(1,1),c(1,2),
            c(2,0),c(2,1),c(2,2),
            c(3,0),c(3,1),c(3,2))
{
plots <- lapply(counts, function(x)
{
  pbp_2020_df %>% 
    filter(matchup.batter.fullName == hitter) %>% 
    # filter(details.call.code == 'S') %>% 
    filter(details.type.code == 'FF') %>% 
    filter(count.balls.start == x[1] & count.strikes.start == x[2]) %>% 
    ggplot(aes(x = pitchData.coordinates.pX, y = pitchData.coordinates.pZ)) +
    geom_point() +
    stat_density_2d_filled() +
    geom_polygon(data = sz, fill = NA, color = 'black') +
    lims(x = c(-2,2), y = c(0,5)) +
    theme(legend.position = 'none',
          axis.text.x = element_blank(),
          axis.title.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.y = element_blank()) +
    ggtitle(paste(x[1], '-', x[2])) 
  })
ggarrange(plotlist = plots)
}

uh <- pbp_2020_df %>% 
  filter(matchup.batter.fullName == hitter) %>% 
  filter(details.call.code == 'S') %>% 
  nrow()
view(uh)

pbp_2020_df %>% 
  filter(matchup.batter.fullName == hitter) %>% 
  nrow()
