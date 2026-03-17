# == Define: types::selboolean
#
# == Define: types::selboolean
#
# @summary
#   Manage SELinux booleans in a standardized way.
#
# @param value
#   The desired value of the SELinux boolean, either 'on' or 'off'.
# @param persistent
#   Whether the change should persist across reboots.
# @param provider
#   Optional provider to use for managing SELinux booleans.
define types::selboolean (
  Enum['on','off'] $value,
  Boolean $persistent = false,
  Optional[String] $provider = undef,
) {
  selboolean { $name:
    value      => $value,
    persistent => $persistent,
    provider   => $provider,
  }
}
