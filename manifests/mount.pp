# == Define: types::mount
#
# @summary
#   Manage mount points in a standardized way.
#
# @param device
#   The device to be mounted (e.g., `/dev/sda1`).
# @param fstype
#   The filesystem type (e.g., `ext4`, `xfs`, `nfs`).
# @param ensure
#   Whether the mount should be present, absent, mounted, or unmounted.
# @param atboot
#   Whether the mount should persist at boot.
# @param blockdevice
#   Optional block device path.
# @param dump
#   Dump frequency for `dump` command.
# @param options
#   Mount options (string or array).
# @param pass
#   Pass number for `fsck`.
# @param provider
#   Mount provider.
# @param remounts
#   Whether the mount can be remounted.
# @param target
#   Mount target path.
define types::mount (
  String $device,
  String $fstype,
  Enum['present','absent','mounted','unmounted'] $ensure = 'mounted',
  Boolean $atboot = true,
  Optional[Stdlib::Absolutepath] $blockdevice = undef,
  Optional[Variant[Integer, String]] $dump = undef,
  Optional[Variant[String, Array[String]]] $options = undef,
  Optional[Variant[Integer, String]] $pass = undef,
  Optional[String] $provider = undef,
  Optional[Boolean] $remounts = undef,
  Optional[Stdlib::Absolutepath] $target = undef,
) {
  if $ensure != 'absent' {
    include common
    common::mkdir_p { $name: }
  }

  if $options == 'defaults' and $facts['os']['family'] == 'Solaris' {
    $options_real = '-'
  } else {
    $options_real = $options
  }

  mount { $name:
    ensure      => $ensure,
    name        => $name,
    atboot      => $atboot,
    blockdevice => $blockdevice,
    device      => $device,
    dump        => $dump,
    fstype      => $fstype,
    options     => $options_real,
    pass        => $pass,
    provider    => $provider,
    remounts    => $remounts,
    target      => $target,
  }

  if $ensure != 'absent' {
    Common::Mkdir_p[$name] -> Mount[$name]
  }
}
