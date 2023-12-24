all_images <- list.files('art/', recursive = TRUE, full.names = TRUE)
all_images <- all_images[tolower(tools::file_ext(all_images)) %in% c('png', 'jpg', 'jpeg')]
for (image in all_images) {
  qmd_file <- paste0(tools::file_path_sans_ext(image), '.qmd')
  img <- basename(image)
  title <- strsplit(tools::file_path_sans_ext(img), split = "(?<=[a-zA-Z])\\s*(?=[0-9])", perl = TRUE)[[1]]
  title <- gsub('_|-', ' ', title)
  title <- tools::toTitleCase(paste(title, collapse = ' '))
  if (fs::file_exists(qmd_file)) {
    fs::file_delete(qmd_file)
  }
  fs::file_create(qmd_file)
  content <- glue::glue('
  ---
  title: "{title}"
  card-style: summary_large_image
  image: {img}
  page-layout: custom
  ---
  
  [\\< Back](index.qmd){{.btn .btn-secondary .btn role="button"}}

  ![]({img}){{style="height:100vh;display:block;margin-left:auto;margin-right:auto;"}}
  
  ')
  cat(content, file = qmd_file)
}
