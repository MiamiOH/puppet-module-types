# == Define: types::file
#
# == Define: types::file
#
# @summary
#   Manage files and directories with standardized parameters.
#
# @param ensure
#   Whether the file should be present, absent, a file, directory, or link.
# @param owner
#   Owner of the file.
# @param group
#   Group of the file.
# @param mode
#   File permissions (4-digit string).
# @param backup
#   Backup setting for the file.
# @param checksum
#   Checksum type (e.g., 'md5', 'sha256').
# @param content
#   Content of the file.
# @param force
#   Force overwrite if needed.
# @param ignore
#   Patterns to ignore when managing the file.
# @param links
#   How symbolic links are managed.
# @param provider
#   Provider to use for the file resource.
# @param purge
#   Whether to purge unmanaged content.
# @param recurse
#   Whether to manage directories recursively.
# @param recurselimit
#   Max recursion depth.
# @param replace
#   Whether to replace the file if content differs.
# @param selinux_ignore_defaults
#   Ignore SELinux defaults.
# @param selrange
#   SELinux range.
# @param selrole
#   SELinux role.
# @param seltype
#   SELinux type.
# @param seluser
#   SELinux user.
# @param show_diff
#   Show diffs of file content.
# @param source
#   Source file(s) for the file resource.
# @param sourceselect
#   How to select source when multiple are provided.
# @param target
#   Target path for the file.
define types::file (
  Enum['present','absent','file','directory','link'] $ensure = 'present',
  Optional[String] $owner = 'root',
  Optional[String] $group = 'root',
  Optional[String[1,4]] $mode = '0644',
  Optional[String] $backup = undef,
  Optional[String] $checksum = undef,
  Optional[String] $content = undef,
  Optional[Boolean] $force = undef,
  Optional[Variant[String, Array[String]]] $ignore = undef,
  Optional[Enum['follow','manage','ignore']] $links = undef,
  Optional[String] $provider = undef,
  Optional[Boolean] $purge = undef,
  Optional[Boolean] $recurse = undef,
  Optional[Integer] $recurselimit = undef,
  Optional[Boolean] $replace = undef,
  Optional[Boolean] $selinux_ignore_defaults = undef,
  Optional[String] $selrange = undef,
  Optional[String] $selrole = undef,
  Optional[String] $seltype = undef,
  Optional[String] $seluser = undef,
  Optional[Boolean] $show_diff = undef,
  Optional[Variant[String, Array[String]]] $source = undef,
  Optional[Enum['first','all']] $sourceselect = undef,
  Optional[Stdlib::Absolutepath] $target = undef,
) {
  file { $name:
    ensure                  => $ensure,
    owner                   => $owner,
    group                   => $group,
    mode                    => $mode,
    checksum                => $checksum,
    content                 => $content,
    backup                  => $backup,
    force                   => $force,
    ignore                  => $ignore,
    links                   => $links,
    provider                => $provider,
    purge                   => $purge,
    recurse                 => $recurse,
    recurselimit            => $recurselimit,
    replace                 => $replace,
    selinux_ignore_defaults => $selinux_ignore_defaults,
    selrange                => $selrange,
    selrole                 => $selrole,
    seltype                 => $seltype,
    seluser                 => $seluser,
    show_diff               => $show_diff,
    source                  => $source,
    sourceselect            => $sourceselect,
    target                  => $target,
  }
}
