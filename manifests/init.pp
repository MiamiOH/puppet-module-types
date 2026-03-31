# @summary
#   Manage common native Puppet resource types via Hiera data or class parameters.
#
# @description
#   The `types` class provides a unified interface for declaring multiple native
#   Puppet resource types (such as cron, package, service, file, mount, etc.)
#   using simple Hash structures.
#
#   Each supported resource type can be supplied directly as a parameter or
#   loaded from Hiera. When a corresponding `*_hiera_merge` option is enabled,
#   the class performs a deep merge lookup from Hiera instead of using the
#   provided parameter value.
#
#   This pattern enables scalable, data-driven resource management while still
#   allowing per-node or per-role overrides.
#
# @param crons
#   Hash of cron resources to create.
#
# @param execs
#   Hash of exec resources to create.
#
# @param file_lines
#   Hash of file_line resources to create.
#
# @param files
#   Hash of file resources to create.
#
# @param mounts
#   Hash of mount resources to create.
#
# @param packages
#   Hash of package resources to create.
#
# @param selbooleans
#   Hash of SELinux boolean resources to manage.
#
# @param services
#   Hash of service resources to manage.
#
# @param crons_hiera_merge
#   Whether to load cron definitions from Hiera using deep merge.
#
# @param execs_hiera_merge
#   Whether to load exec definitions from Hiera using deep merge.
#
# @param file_lines_hiera_merge
#   Whether to load file_line definitions from Hiera using deep merge.
#
# @param files_hiera_merge
#   Whether to load file definitions from Hiera using deep merge.
#
# @param mounts_hiera_merge
#   Whether to load mount definitions from Hiera using deep merge.
#
# @param packages_hiera_merge
#   Whether to load package definitions from Hiera using deep merge.
#
# @param selbooleans_hiera_merge
#   Whether to load SELinux boolean definitions from Hiera using deep merge.
#
# @param services_hiera_merge
#   Whether to load service definitions from Hiera using deep merge.
#
# @example Basic usage with direct parameters
#   class { 'types':
#     packages => {
#       'htop' => { 'ensure' => 'present' },
#       'vim'  => { 'ensure' => 'latest' },
#     },
#   }
#
# @example Using Hiera data (recommended)
#   # In Hiera:
#   # types::packages:
#   #   git:
#   #     ensure: latest
#   #   vim:
#   #     ensure: present
#
#   class { 'types':
#     packages_hiera_merge: true,
#   }
#
# @example Mixed usage (override specific resources)
#   class { 'types':
#     packages_hiera_merge => true,
#     packages => {
#       'custom-package' => { 'ensure' => 'present' },
#     },
#   }
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
  # Convert string values to Boolean
  $crons_hiera_merge_real       = Boolean($crons_hiera_merge)
  $execs_hiera_merge_real       = Boolean($execs_hiera_merge)
  $file_lines_hiera_merge_real  = Boolean($file_lines_hiera_merge)
  $files_hiera_merge_real       = Boolean($files_hiera_merge)
  $mounts_hiera_merge_real      = Boolean($mounts_hiera_merge)
  $packages_hiera_merge_real    = Boolean($packages_hiera_merge)
  $selbooleans_hiera_merge_real = Boolean($selbooleans_hiera_merge)
  $services_hiera_merge_real    = Boolean($services_hiera_merge)

  # ------------------------------------------------------------------
  # Crons
  # ------------------------------------------------------------------
  $crons_real = $crons_hiera_merge_real ? {
    true  => lookup('types::crons', { merge => 'deep', default_value => {} }),
    false => $crons,
  }
  if $crons_real and $crons_real != {} {
    $crons_real.each |$title, $params| {
      types::cron { $title:
        * => $params,
      }
    }
  }

  # ------------------------------------------------------------------
  # Execs
  # ------------------------------------------------------------------
  $execs_real = $execs_hiera_merge_real ? {
    true  => lookup('types::execs', { merge => 'deep', default_value => {} }),
    false => $execs,
  }
  if $execs_real and $execs_real != {} {
    $execs_real.each |$title, $params| {
      types::exec { $title:
        * => $params,
      }
    }
  }

  # ------------------------------------------------------------------
  # File_lines
  # ------------------------------------------------------------------
  $file_lines_real = $file_lines_hiera_merge_real ? {
    true  => lookup('types::file_lines', { merge => 'deep', default_value => {} }),
    false => $file_lines,
  }
  if $file_lines_real and $file_lines_real != {} {
    $file_lines_real.each |$title, $params| {
      types::file_line { $title:
        * => $params,
      }
    }
  }

  # ------------------------------------------------------------------
  # Files
  # ------------------------------------------------------------------
  $files_real = $files_hiera_merge_real ? {
    true  => lookup('types::files', { merge => 'deep', default_value => {} }),
    false => $files,
  }
  if $files_real and $files_real != {} {
    $files_real.each |$title, $params| {
      types::file { $title:
        * => $params,
      }
    }
  }

  # ------------------------------------------------------------------
  # Mounts
  # ------------------------------------------------------------------
  $mounts_real = $mounts_hiera_merge_real ? {
    true  => lookup('types::mounts', { merge => 'deep', default_value => {} }),
    false => $mounts,
  }
  if $mounts_real and $mounts_real != {} {
    $mounts_real.each |$title, $params| {
      types::mount { $title:
        * => $params,
      }
    }
  }

  # ------------------------------------------------------------------
  # Packages
  # ------------------------------------------------------------------
  $packages_real = $packages_hiera_merge_real ? {
    true  => lookup('types::packages', { merge => 'deep', default_value => {} }),
    false => $packages,
  }
  if $packages_real and $packages_real != {} {
    $packages_real.each |$title, $params| {
      types::package { $title:
        * => $params,
      }
    }
  }

  # ------------------------------------------------------------------
  # Selbooleans
  # ------------------------------------------------------------------
  $selbooleans_real = $selbooleans_hiera_merge_real ? {
    true  => lookup('types::selbooleans', { merge => 'deep', default_value => {} }),
    false => $selbooleans,
  }
  if $selbooleans_real and $selbooleans_real != {} {
    $selbooleans_real.each |$title, $params| {
      types::selboolean { $title:
        * => $params,
      }
    }
  }

  # ------------------------------------------------------------------
  # Services
  # ------------------------------------------------------------------
  $services_real = $services_hiera_merge_real ? {
    true  => lookup('types::services', { merge => 'deep', default_value => {} }),
    false => $services,
  }
  if $services_real and $services_real != {} {
    $services_real.each |$title, $params| {
      types::service { $title:
        * => $params,
      }
    }
  }
}
