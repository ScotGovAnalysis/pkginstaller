clean_pkg_str <- function(pkg_str) {
  # Remove whitespace
  pkg_str <- gsub(" ", "", pkg_str)

  # Fail if anything not character, number, comma
  if (grepl("[^0-9a-z,]", pkg_str, ignore.case = TRUE)) {
    stop("Error in package names entered (char, number, commas only)")
  }

  # split at commas to vector
  unlist(strsplit(pkg_str, ","))
}



#' Install R package from internal server
#'
#' To be used in R Studio, optionally as an add-in. A pop-up window will ask
#' to enter name of package wish to install. If wish to enter more than one
#' package separate the names with commas
#'
#' @export
#'
#' @examples
#' \dontrun{
#' package_installer()
#' }
package_installer <- function() {
  pkgs_server <- get_server_path()

  pkg_name <- rstudioapi::showPrompt(
    "Enter Package Name(s)",
    paste0(
      "Install from ",
      substr(pkgs_server, 6, nchar(pkgs_server)),
      "\nSeparate package names by comma if multiple"
    )
  )

  pkg_name <- clean_pkg_str(pkg_name)

  utils::install.packages(pkg_name,
    repos = NULL,
    type = "win.binary",
    contriburl = pkgs_server
  )
}
