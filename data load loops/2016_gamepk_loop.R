library(tidyverse)
library(baseballr)

# get pbp for 2016 #

game_info <- baseballr::get_game_info_sup_petti()

game_pks <- game_info %>% 
  filter(substr(game_date, 1, 4) == 2016, status_ind == 'F')

num_of_games <- nrow(game_pks)

pbp_2016_df <- map_df(.x = seq_along(game_pks$game_pk),
                      ~{
                        message(paste0('grabbing pbp for game ', .x, ' of ', num_of_games))
                        
                        df <- get_pbp_mlb(game_pk = game_pks$game_pk[.x])
                        
                        return(df)
                        
                      })