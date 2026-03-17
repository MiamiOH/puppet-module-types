# == Define: types::file_line
#
# == Define: types::file_line
#
# @summary
#   Manage individual lines in a file using the file_line resource.
#
# @param path
#   Absolute path to the file.
# @param line
#   The line to ensure is present or absent.
# @param match
#   Optional regex to match an existing line for replacement.
# @param ensure
#   Whether the line should be present or absent.
define types::file_line (
  Stdlib::Absolutepath $path,
  String               $line,
  Optional[String]     $match  = undef,
  Enum['present','absent'] $ensure = 'present',
) {
  file_line { $name:
    ensure => $ensure,
    path   => $path,
    line   => $line,
    match  => $match,
  }
}
