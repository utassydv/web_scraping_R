rm(list=ls())

library(data.table)
library(rvest)
# testing function for one page, with given keyword
my_url <- 'https://www.jofogas.hu/magyarorszag?q=asztal'
t <- read_html(my_url)
boxes <- t %>% 
  html_nodes('.contentArea')
x <- boxes[[1]]
boxes_df <- lapply(boxes, function(x){
  t_list <- list()
  t_list[['title']] <- x %>% html_nodes('.subject') %>% html_text()
  t_list[['link']] <- x %>% html_nodes('.subject') %>% html_attr('href')
  t_list[['price']]  <- x %>% html_nodes('.price-value') %>% html_text()
  t_list[['category']]  <- x %>% html_nodes('.category') %>% html_text()
  t_list[['location']]  <- x %>% html_nodes('.cityname') %>% html_text()
  t_list[['upload_time']]  <- x %>% html_nodes('.time') %>% html_text()
  
  return(data.frame(t_list))  
  
})
df <- rbindlist(boxes_df)

#using a function to get one page
get_one_page_from_jofogas  <- function(my_url) {
  print(my_url)
  t <- read_html(my_url)
  boxes <- t %>% 
    html_nodes('.contentArea')
  x <- boxes[[1]]
  
  boxes_df <- lapply(boxes, function(x){
    t_list <- list()
    t_list[['title']] <- x %>% html_nodes('.subject') %>% html_text()
    t_list[['link']] <- x %>% html_nodes('.subject') %>% html_attr('href')
    t_list[['price']]  <- x %>% html_nodes('.price-value') %>% html_text()
    t_list[['category']]  <- x %>% html_nodes('.category') %>% html_text()
    t_list[['location']]  <- x %>% html_nodes('.cityname') %>% html_text()
    t_list[['upload_time']]  <- x %>% html_nodes('.time') %>% html_text()
    return(data.frame(t_list))  
  })
  
  df <- rbindlist(boxes_df)
  return(df)
}

# searchterm <- 'asztal'
# page_to_download <- 5


# a function with setable searchterm and page number to download as arguments
get_jofogas <- function(searchterm, page_to_download) {
  # create links
 links_to_get <- 
  paste0('https://www.jofogas.hu/magyarorszag?q=',searchterm, '&o=', seq(1, page_to_download))
 ret_df <- rbindlist(lapply(links_to_get, get_one_page_from_jofogas))
  return(ret_df)
}

df <- get_jofogas(searchterm = 'asztal', 3)

saveRDS(df, file = '/Users/utassydv/Documents/workspaces/CEU/my_repos/web_scraping_R/homeworks/project1/output.rds')
write.csv(df, file = '/Users/utassydv/Documents/workspaces/CEU/my_repos/web_scraping_R/homeworks/project1/output.csv')
