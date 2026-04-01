# == Define: types::service
#
# @summary
#   Manage services in a standardized way.
#
# @param ensure
#   Desired state of the service: 'running', 'stopped', 'true', or 'false'.
# @param binary
#   Optional path to the service binary.
# @param control
#   Optional control command.
# @param enable
#   Whether the service should be enabled: Boolean or 'manual'.
# @param hasrestart
#   Indicates whether the service has a restart command.
# @param hasstatus
#   Indicates whether the service has a status command.
# @param manifest
#   Optional service manifest file.
# @param path
#   Optional path for the service.
# @param pattern
#   Optional pattern for service matching.
# @param provider
#   Optional service provider.
# @param restart
#   Optional restart command.
# @param start
#   Optional start command.
# @param status
#   Optional status command.
# @param stop
#   Optional stop command.
define types::service (
  Enum['running','stopped','true','false'] $ensure = 'running',
  Optional[String] $binary = undef,
  Optional[String] $control = undef,
  Variant[Boolean,Enum['manual']] $enable = true,
  Optional[Boolean] $hasrestart = undef,
  Optional[Boolean] $hasstatus  = undef,
  Optional[String] $manifest = undef,
  Optional[String] $path = undef,
  Optional[String] $pattern = undef,
  Optional[String] $provider = undef,
  Optional[String] $restart = undef,
  Optional[String] $start = undef,
  Optional[String] $status = undef,
  Optional[String] $stop = undef,
) {
  service { $name:
    ensure     => $ensure,
    binary     => $binary,
    control    => $control,
    enable     => $enable,
    hasrestart => $hasrestart,
    hasstatus  => $hasstatus,
    manifest   => $manifest,
    path       => $path,
    pattern    => $pattern,
    provider   => $provider,
    restart    => $restart,
    start      => $start,
    status     => $status,
    stop       => $stop,
  }
}
