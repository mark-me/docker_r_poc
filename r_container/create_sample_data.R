library(tidyverse)
library(magrittr)
library(graydon.package)

df_market <- read_rds("r_container/data/market_integrated.RDS")
# Create sample of all companies
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


# Create sector summary ----
df_sector <- df_market %>% 
  group_by(code_sbi,
           rating_pd,
           rating_discontinuation_grp,
           score_growth_label
           ) %>% 
  summarise(qty_companies = n()            ) %>% 
  ungroup()
  
write_rds(df_sector, "data/sector.RDS")

# Create market graph ----
tbl_market_graph <- df_market %>% 
  mutate(id_mothercompany = ifelse(id_mothercompany == "", NA, id_mothercompany)) %>% 
  filter(!is.na(id_mothercompany)) %>% 
  select(id_graydon, id_mothercompany)
    
graph_company_hierarchies <- create_graph_company_hierarchies(tbl_market_graph)
df_market_concerns <- hierarchy_as_data_frame(graph_company_hierarchies) 
df_market_concerns %<>% select(id_graydon = name)

tbl_market_graph <- df_market_concerns %>% 
  inner_join(df_market, by = "id_graydon") %>% 
  mutate(id_mothercompany = ifelse(id_mothercompany== "", NA, id_mothercompany)) %>% 
  select(id_graydon, 
         id_mothercompany,
         name_company,
         code_legal_form, 
         is_stopped, 
         rating_pd, 
         type_company,
         is_active,
         lon, lat,
         rating_discontinuation,
         description_SBI
  )

graph_company_hierarchies <- create_graph_company_hierarchies(tbl_market_graph)
    
write_rds(graph_company_hierarchies, "r_container/data/company_graph.rds")




