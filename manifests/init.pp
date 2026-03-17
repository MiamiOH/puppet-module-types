# @summary
#   Manage resource types (cron, exec, file, etc.) via parameters or Hiera.
#
# @description
#   This class creates defined resources from hashes provided either directly
#   as class parameters or via Hiera lookups.
#
#   When a *_hiera_merge parameter is set to true, the corresponding parameter
#   value is ignored and data is loaded from Hiera using a deep merge strategy.
#
# @param crons
#   Optional hash of cron resources to create.
#
# @param execs
#   Optional hash of exec resources to create.
#
# @param file_lines
#   Optional hash of file_line resources to create.
#
# @param files
#   Optional hash of file resources to create.
#
# @param mounts
#   Optional hash of mount resources to create.
#
# @param packages
#   Optional hash of package resources to create.
#
# @param selbooleans
#   Optional hash of selboolean resources to create.
#
# @param services
#   Optional hash of service resources to create.
#
# @param crons_hiera_merge
#   If true, load cron resources from Hiera instead of the crons parameter.
#
# @param execs_hiera_merge
#   If true, load exec resources from Hiera instead of the execs parameter.
#
# @param file_lines_hiera_merge
#   If true, load file_line resources from Hiera instead of the file_lines parameter.
#
# @param files_hiera_merge
#   If true, load file resources from Hiera instead of the files parameter.
#
# @param mounts_hiera_merge
#   If true, load mount resources from Hiera instead of the mounts parameter.
#
# @param packages_hiera_merge
#   If true, load package resources from Hiera instead of the packages parameter.
#
# @param selbooleans_hiera_merge
#   If true, load selboolean resources from Hiera instead of the selbooleans parameter.
#
# @param services_hiera_merge
#   If true, load service resources from Hiera instead of the services parameter.
class types (
  Optional[Hash] $crons                   = undef,
  Optional[Hash] $execs                   = undef,
  Optional[Hash] $file_lines              = undef,
  Optional[Hash] $files                   = undef,
  Optional[Hash] $mounts                  = undef,
  Optional[Hash] $packages                = undef,
  Optional[Hash] $selbooleans             = undef,
  Optional[Hash] $services                = undef,

  Variant[Boolean, String] $crons_hiera_merge       = false,
  Variant[Boolean, String] $execs_hiera_merge       = false,
  Variant[Boolean, String] $file_lines_hiera_merge  = true,
  Variant[Boolean, String] $files_hiera_merge       = false,
  Variant[Boolean, String] $mounts_hiera_merge      = false,
  Variant[Boolean, String] $packages_hiera_merge    = true,
  Variant[Boolean, String] $selbooleans_hiera_merge = true,
  Variant[Boolean, String] $services_hiera_merge    = true,
) {
  $crons_hiera_merge_real       = Boolean($crons_hiera_merge)
  $execs_hiera_merge_real       = Boolean($execs_hiera_merge)
  $file_lines_hiera_merge_real  = Boolean($file_lines_hiera_merge)
  $files_hiera_merge_real       = Boolean($files_hiera_merge)
  $mounts_hiera_merge_real      = Boolean($mounts_hiera_merge)
  $packages_hiera_merge_real    = Boolean($packages_hiera_merge)
  $selbooleans_hiera_merge_real = Boolean($selbooleans_hiera_merge)
  $services_hiera_merge_real    = Boolean($services_hiera_merge)

  if $crons != undef {
    $crons_real = $crons_hiera_merge_real ? {
      true  => lookup('types::crons', { merge => 'deep', default_value => {} }),
      false => $crons,
    }

    $crons_real.each |$title, $params| {
      types::cron { $title:
        * => $params,
      }
    }
  }

  if $execs != undef {
    $execs_real = $execs_hiera_merge_real ? {
      true  => lookup('types::execs', { merge => 'deep', default_value => {} }),
      false => $execs,
    }

    $execs_real.each |$title, $params| {
      types::exec { $title:
        * => $params,
      }
    }
  }

  if $file_lines != undef {
    $file_lines_real = $file_lines_hiera_merge_real ? {
      true  => lookup('types::file_lines', { merge => 'deep', default_value => {} }),
      false => $file_lines,
    }

    $file_lines_real.each |$title, $params| {
      types::file_line { $title:
        * => $params,
      }
    }
  }

  if $files != undef {
    $files_real = $files_hiera_merge_real ? {
      true  => lookup('types::files', { merge => 'deep', default_value => {} }),
      false => $files,
    }

    $files_real.each |$title, $params| {
      types::file { $title:
        * => $params,
      }
    }
  }

  if $mounts != undef {
    $mounts_real = $mounts_hiera_merge_real ? {
      true  => lookup('types::mounts', { merge => 'deep', default_value => {} }),
      false => $mounts,
    }

    $mounts_real.each |$title, $params| {
      types::mount { $title:
        * => $params,
      }
    }
  }

  if $packages != undef {
    $packages_real = $packages_hiera_merge_real ? {
      true  => lookup('types::packages', { merge => 'deep', default_value => {} }),
      false => $packages,
    }

    $packages_real.each |$title, $params| {
      types::package { $title:
        * => $params,
      }
    }
  }

  if $selbooleans != undef {
    $selbooleans_real = $selbooleans_hiera_merge_real ? {
      true  => lookup('types::selbooleans', { merge => 'deep', default_value => {} }),
      false => $selbooleans,
    }

    $selbooleans_real.each |$title, $params| {
      types::selboolean { $title:
        * => $params,
      }
    }
  }

  if $services != undef {
    $services_real = $services_hiera_merge_real ? {
      true  => lookup('types::services', { merge => 'deep', default_value => {} }),
      false => $services,
    }

    $services_real.each |$title, $params| {
      types::service { $title:
        * => $params,
      }
    }
  }
}
