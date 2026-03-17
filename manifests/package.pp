# == Define: types::package
#
# == Define: types::package
#
# @summary
#   Manage packages in a standardized way.
#
# @param ensure
#   Whether the package should be present, absent, installed, or purged.
# @param adminfile
#   Absolute path to the admin file (for AIX / Windows packages).
# @param allowcdrom
#   Whether CD-ROM media is allowed for installation.
# @param configfiles
#   What to do with config files ('keep' or 'replace').
# @param install_options
#   Options passed to the package provider for installation.
# @param provider
#   Package provider to use (e.g., 'apt', 'yum', 'rpm').
# @param responsefile
#   Absolute path to a response file.
# @param source
#   Package source location.
# @param uninstall_options
#   Options passed to the package provider for uninstallation.
define types::package (
  Enum['present','absent','installed','purged'] $ensure = 'present',
  Optional[Stdlib::Absolutepath] $adminfile = undef,
  Optional[Boolean] $allowcdrom = undef,
  Optional[Enum['keep','replace']] $configfiles = undef,
  Optional[Variant[String, Array[String]]] $install_options = undef,
  Optional[String] $provider = undef,
  Optional[Stdlib::Absolutepath] $responsefile = undef,
  Optional[Variant[String, Array[String]]] $source = undef,
  Optional[Variant[String, Array[String]]] $uninstall_options = undef,
) {
  package { $name:
    ensure            => $ensure,
    adminfile         => $adminfile,
    allowcdrom        => $allowcdrom,
    configfiles       => $configfiles,
    install_options   => $install_options,
    provider          => $provider,
    responsefile      => $responsefile,
    source            => $source,
    uninstall_options => $uninstall_options,
  }
}
