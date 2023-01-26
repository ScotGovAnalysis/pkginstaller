get_server_path <- function() {
  tryCatch(
    {
      server_path <- readLines("packages_server_path.txt")[[1]]
    },
    error = function(e) {
      stop("cannot find packages_server_path")
    }
  )
  if (nchar(server_path) == 0) {
    stop("no packages server specified in 'packages_server_path.txt'")
  } else if (substr(server_path, 0, 5) != "file:") {
    server_path <- paste0("file:", server_path)
  }
  return(server_path)
}


#' Install R package from internal server
#'
#' To be used in R Studio, optionally as an add-in. A pop-up window will ask
#' to enter name of package wish to install.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' package_installer()
#' }
package_installer <- function() {
  pkg_name <- rstudioapi::showPrompt("Package Name", "Enter package name")
  pkgs_server <- get_server_path()
  utils::install.packages(pkg_name,
    repos = NULL,
    type = "win.binary",
    contriburl = pkgs_server
  )
}
