

library(glue)
library(fs)

tpl <- "
---
format:
  html:
    keep-md: false
    css: ../resources/css/gallery.css
    toc: false
title: <album>
album: <album>
editor: source
lightbox: auto
---

::: gallery

::: column-page


```{r, results='asis', echo=FALSE, warning=FALSE, message=FALSE}
library(glue)
library(fs)
album = rmarkdown::metadata$album
localurl =  path('../resources/images', album)
photos = dir_ls(path = localurl)
photos = photos[grepl('\\\\.jpe?g$', photos, ignore.case = TRUE)]
  
for (i in seq_along(photos)){
  if(i %in% c(1)) span = 'all' else span = 'none'

  cat(glue('![]({{ localurl }}/{{ path_file(photos[i]) }}){.lightbox style=\"column-span: {{ span }};\" group=\"<album>-gallery\"}', .open = '{{', .close = '}}'), '\n')

}
```
:::

:::
"


folder_paths = dir_ls("resources/images", type = "directory")

la = path_file(folder_paths)

for (album in la){
  group_path = glue('pic_groups/{album}.qmd')
  cat(glue(tpl, .open = '<', .close = '>'), file = group_path)
}
