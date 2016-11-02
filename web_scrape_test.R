library(rvest)

## na function

html_text_na <- function(x) {
  
  txt <- try(html_text(x))
  if (inherits(txt, "try-error") |
      (length(txt)==0)) { return(NA) }
  return(txt)
  
}

## lego movie

lego_movie = read_html("http://www.imdb.com/title/tt1490017/")

rating = lego_movie %>% html_node("strong span") %>% html_text() %>% as.numeric()

cast = lego_movie %>% html_nodes("#titleCast .itemprop span") %>% html_text()

comments = lego_movie %>% html_nodes("table") %>% .[[2]] %>% html_table()



mac_search = read_html("http://provo.craigslist.org/search/sss?sort=rel&query=macbook%20pro")

price = mac_search %>% html_nodes(".rows span .price") %>% html_text_na %>% html_text()
title = mac_search %>% html_nodes(".rows .txt .hdrlnk") %>% html_text()

