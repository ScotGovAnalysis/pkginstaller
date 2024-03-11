#' Check package versions between server collection and those installed
#'
#' Where applicable gives the option to upgrade installed packages from server
#' and to downgrade and install the server version where currently exceeded.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' check_package_versions()
#' }
check_package_versions <- function() {
  pkgs_server <- get_server_path()

  # List all zip files in the directory
  search_dir <- sub("file:", "", pkgs_server)
  zip_files <- list.files(search_dir, pattern = "\\.zip$", full.names = FALSE)

  if (length(zip_files) == 0) {
    stop("No packages found. Check server packages directory")
  }

  package_name <- sub("_.*", "", zip_files)

  server_v <- sub("^.*?_", "", zip_files)

  server_v <- sub("\\.zip", "", server_v)

  server_v <- sub("-", "\\.", server_v)

  df_all <- data.frame(package_name, server_v)

  # Add installed version to new column in same format
  cat("Getting version of each installed package...\n")
  df_all$installed_version <- sapply(df_all$package_name, function(x) {
    # tryCatch as packages on server might not be installed
    tryCatch(
      {
        version <- as.character(utils::packageVersion(x))
      },
      error = function(e) {
        NA
      }
    )
  })

  # Filter to just Where installed
  # but server version does not match installed version
  df_all <- df_all[(!is.na(df_all$installed_version)) &
    (df_all$server_v != df_all$installed_version), ]

  if (nrow(df_all) == 0) {
    cat("All installed packages match server version")
  }

  # If packages which could be upgraded give the option
  df_upgrade <- df_all[numeric_version(df_all$server_v) >
    numeric_version(df_all$installed_version), ]

  if (nrow(df_upgrade) > 0) {
    cat(
      "These", nrow(df_upgrade),
      "packages can be upgraded from the server:\n"
    )
    cat(df_upgrade$package_name, sep = "\n")
    user_response <- tolower(readline(
      prompt =
        "Do you want to upgrade them now? (y/n)"
    ))
    if (user_response %in% c("y", "yes")) {
      cat("Upgrading ", nrow(df_upgrade), " packages...\n")
      utils::install.packages(df_upgrade$package_name,
        repos = NULL,
        type = "win.binary",
        contriburl = pkgs_server
      )
    } else {
      cat("Not proceeding with package upgrades.\n")
    }
  }


  # If packages which could be downgraded give the option
  df_downgrade <- df_all[numeric_version(df_all$server_v) <
    numeric_version(df_all$installed_version), ]

  if (nrow(df_downgrade) > 0) {
    cat("These", nrow(df_downgrade),
        "packages exceed the version on the server:\n")
    cat(df_downgrade$package_name, sep = "\n")
    q <- "Do you want to uninstall them and install their server version? (y/n)"
    user_response <- tolower(readline(prompt = q))
    if (user_response %in% c("y", "yes")) {
      cat("Downgrading ", nrow(df_downgrade), " packages...\n")
      utils::remove.packages(df_downgrade$package_name)
      utils::install.packages(df_downgrade$package_name,
        repos = NULL,
        type = "win.binary",
        contriburl = pkgs_server
      )
    } else {
      cat("Not proceeding with package downgrades.")
    }
  }
}
