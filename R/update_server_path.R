#' Set server path containing packages to install.
#'
#' This is only needed if get_server_path() shows current path needs changing.
#' It will only need to be set once as the path specified will be stored (
#' inside the package install) for all subsequent uses of the
#' package_installer() function.
#'
#'
#' @export
#'
#' @examples
#' \dontrun{
#' update_server_path()
#' }
update_server_path <- function() {
  server_path <- rstudioapi::showPrompt("server path",
                                        "Enter path to packages directory",
                                        default=get_server_path())
  if (nchar(server_path)==0){
    server_path <- get_server_path()
  }
  server_fp <- system.file("serverconf/packages_server_path.txt",
    package = "pkginstaller",
    mustWork = TRUE
  )
  write(server_path, server_fp)
}
