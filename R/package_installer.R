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
