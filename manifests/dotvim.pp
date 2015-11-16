# See README.md for documentation.
define vim::dotvim (
  $user,
  $user_home = $title,
) {
  validate_string($user)
  validate_absolute_path($user_home)

  $dotvim_path = "${user_home}/.vim"
  vcsrepo { $dotvim_path:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/teleivo/dotvim.git',
    user     => $user,
  }

  file { "${user_home}/.vimrc":
    ensure => link,
    owner  => $user,
    target => "${dotvim_path}/vimrc",
  }
}
