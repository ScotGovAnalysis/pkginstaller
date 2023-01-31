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
  original_path <- get_server_path()

  default_path <- substr(original_path, 6, nchar(get_server_path()))

  server_path <- rstudioapi::showPrompt("server path",
    "Enter path to packages directory",
    default = default_path
  )

  if (is.null(server_path)) {
    server_path <- original_path
  }

  server_fp <- system.file("serverconf/packages_server_path.txt",
    package = "pkginstaller",
    mustWork = TRUE
  )

  write(server_path, server_fp)
}
