# == Define: types::cron
#
# @summary
#   Manage cron jobs in a standardized way.
#
# @param command
#   The command to be executed by the cron job.
#
# @param ensure
#   Whether the cron job should be present or absent.
#
# @param environment
#   Environment variables for the cron job (string or array).
#
# @param hour
#   The hour the job should run (0-23 or '*').
#
# @param minute
#   The minute the job should run (0-59 or '*').
#
# @param month
#   The month the job should run (1-12 or '*').
#
# @param monthday
#   The day of the month the job should run (1-31 or '*').
#
# @param provider
#   The cron provider to use.
#
# @param special
#   A special time specification (e.g., 'reboot', 'daily').
#
# @param target
#   The file where the cron job should be stored.
#
# @param user
#   The user who owns the cron job.
#
# @param weekday
#   The weekday the job should run (0-7 or '*').
#
define types::cron (
  String                         $command,
  Enum['present', 'absent']      $ensure      = 'present',
  Optional[Variant[String,Array[String]]] $environment = undef,
  Optional[String]               $hour        = undef,
  Optional[String]               $minute      = undef,
  Optional[String]               $month       = undef,
  Optional[String]               $monthday    = undef,
  Optional[String]               $provider    = undef,
  Optional[String]               $special     = undef,
  Optional[String]               $target      = undef,
  Optional[String]               $user        = undef,
  Optional[String]               $weekday     = undef,
) {
  cron { $name:
    ensure      => $ensure,
    command     => $command,
    environment => $environment,
    hour        => $hour,
    minute      => $minute,
    month       => $month,
    monthday    => $monthday,
    provider    => $provider,
    special     => $special,
    target      => $target,
    user        => $user,
    weekday     => $weekday,
  }
}
