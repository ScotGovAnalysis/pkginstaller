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
  pkgs_server <- get_server_path()
  pkg_name <- rstudioapi::showPrompt(
    "Enter Package Name",
    paste(
      "Package to install from",
      substr(pkgs_server, 6, nchar(pkgs_server))
    )
  )
  utils::install.packages(pkg_name,
    repos = NULL,
    type = "win.binary",
    contriburl = pkgs_server
  )
}
