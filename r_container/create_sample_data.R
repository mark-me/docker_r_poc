library(tidyverse)
library(magrittr)
library(graydon.package)

df_network <- df_market %>% 
  select(id_graydon,
         id_mothercompany) %>% 
  mutate(id_mothercompany = ifelse(id_mothercompany != "", id_mothercompany, NA))

tbl_market_graph <- df_network %>% 
  mutate(id_mothercompany = ifelse(id_mothercompany == "", NA, id_mothercompany)) %>% 
  filter(!is.na(id_mothercompany)) %>% 
  select(id_graydon, id_mothercompany)

graph_company_hierarchies <- create_graph_company_hierarchies(tbl_market_graph)
tbl_market <- hierarchy_as_data_frame(graph_company_hierarchies) 
tbl_market %<>% select(id_graydon = name)

tbl_market_sample <- tbl_market %>% 
  inner_join(df_market, by = "id_graydon") %>% 
  mutate(id_mothercompany = ifelse(id_mothercompany== "", NA, id_mothercompany))

write_rds(tbl_market_sample, "data/market_sample.RDS")

df_sector <- df_market %>% 
  group_by(code_sbi,
           rating_pd,
           rating_discontinuation_grp,
           score_growth_label
           ) %>% 
  summarise(qty_companies = n()            ) %>% 
  ungroup()
  
write_rds(df_sector, "data/sector.RDS")
