rm(list=ls())

#lapply
my_list <- 1:10

my_numbers <- NULL
for (i in 1:10){
  my_numbers <- c(my_numbers, i^2)
}

lapply(1:10, function(x){
  return(x^2)
})

my_square <- function(x){
  return(x^2)
}


lapply(1:10, my_square)


letters

my_upper <- function(x) {
  return(paste0('#',toupper(x),'#'))
}

t <- lapply(letters,my_upper)

#sapply returning with vector
v <- sapply(letters,my_upper)

#to get vect from lapply
unlist( 
lapply(letters,my_upper)
)

#webscraping
install.packages("rvest")
library(rvest)


t <- read_html('https://www.wired.com/search/?q=big%20data&page=1&sort=score')
write_html(t, 't.html')

titles<- 
  t %>% 
  html_nodes('.archive-item-component__title') %>% 
  html_text()

time<- 
  t %>% 
  html_nodes('time') %>% 
  html_text()

summary<- 
  t %>% 
  html_nodes('.archive-item-component__desc') %>% 
  html_text()

my_link<- 
  t %>% 
  html_nodes('.archive-link-component') %>% 
  html_attr('href')
 
my_link 

df <- data.frame('title' = titles, 'links' = my_link, '')
