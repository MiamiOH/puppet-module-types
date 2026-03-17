# == Define: types::exec
#
# == Define: types::exec
#
# @summary
#   Manage exec resources in a standardized way.
#
# @param command
#   The command to execute.
# @param creates
#   Path to a file that prevents the command from running if it exists.
# @param cwd
#   Current working directory for the command.
# @param environment
#   Environment variables to set (string or array of strings).
# @param group
#   The group to run the command as.
# @param logoutput
#   Whether to log command output.
# @param onlyif
#   Command to run before the main command; executes main only if this succeeds.
# @param path
#   The system path for the command.
# @param provider
#   The exec provider (`posix`, `shell`, `windows`).
# @param refresh
#   Resource to refresh.
# @param refreshonly
#   Whether to run only on refresh.
# @param returns
#   Expected exit codes.
# @param timeout
#   Execution timeout in seconds.
# @param tries
#   Number of retry attempts.
# @param try_sleep
#   Seconds to wait between retries.
# @param unless
#   Command to prevent execution if it succeeds.
# @param user
#   The user to run the command as.
define types::exec (
  String $command,
  Optional[Stdlib::Absolutepath] $creates     = undef,
  Optional[Stdlib::Absolutepath] $cwd         = undef,
  Optional[Variant[String, Array[String]]] $environment = undef,
  Optional[String] $group       = undef,
  Optional[String] $logoutput   = undef,
  Optional[String] $onlyif      = undef,
  Optional[Variant[String, Array[String]]] $path        = undef,
  Optional[Enum['posix','shell','windows']] $provider = undef,
  Optional[String] $refresh     = undef,
  Optional[Boolean] $refreshonly = undef,
  Optional[Variant[Integer, Array[Integer]]] $returns     = undef,
  Optional[Integer] $timeout     = undef,
  Optional[Integer] $tries       = undef,
  Optional[Integer] $try_sleep   = undef,
  Optional[String] $unless      = undef,
  Optional[String] $user        = undef,
) {
  exec { $name:
    command     => $command,
    creates     => $creates,
    cwd         => $cwd,
    environment => $environment,
    group       => $group,
    logoutput   => $logoutput,
    onlyif      => $onlyif,
    path        => $path,
    provider    => $provider,
    refresh     => $refresh,
    refreshonly => $refreshonly,
    returns     => $returns,
    timeout     => $timeout,
    tries       => $tries,
    try_sleep   => $try_sleep,
    unless      => $unless,
    user        => $user,
  }
}
