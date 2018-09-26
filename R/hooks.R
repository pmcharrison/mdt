.onLoad <- function(libname, pkgname) {
  packageStartupMessage(
    "Note: on September 26th 2018, the following change was made to ",
    "default arguments for mdt(), demo_mdt(), and standalone_mdt():\n",
    "- next_item.estimator now defaults to 'BM', not 'WL'.\n"
  )
}
