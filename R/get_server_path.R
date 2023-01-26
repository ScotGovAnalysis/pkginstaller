#' Get the current path used to find R packages.
#'
#' This should be the directory containing Windows zipped binary files.
#'
#' @return Char of server path.
#' @export
#'
#' @examples
#' \dontrun{
#' get_server_path()
#' }
get_server_path <- function() {
  server_fp <- system.file("packages_server_path.txt",
                           package = "pkginstaller",
                           mustWork = TRUE
  )

  server_path <- readLines(server_fp)[[1]]

  if (nchar(server_path) == 0) {
    stop("no packages server specified in 'packages_server_path.txt'")
  } else if (substr(server_path, 0, 5) != "file:") {
    server_path <- paste0("file:", server_path)
  }
  return(server_path)
}
