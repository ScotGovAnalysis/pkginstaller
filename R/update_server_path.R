#' Set server path containing packages to install.
#'
#' This is only needed if get_server_path() shows current path needs changing.
#' It will only need to be set once as the path specified will be stored (
#' inside the package install) for all subsequent uses of the
#' package_installer() function.
#'
#' @param server_path char specifying server path to use
#' (in UNC format e.g //my_server/my_directory)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' update_server_path("//my_server/all_R/R_4_2_2")
#' }
update_server_path <- function(server_path) {
  server_fp <- system.file("serverconf/packages_server_path.txt",
    package = "pkginstaller",
    mustWork = TRUE
  )
  write(server_path, server_fp)
}
