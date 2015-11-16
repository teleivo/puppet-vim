Exec {
    path => [ '/usr/bin', '/bin', '/usr/sbin', '/sbin' ]
}

package {
  [
    'git',
    'vim',
  ]:
}

user { 'teleivo':
  ensure     => present,
  managehome => true,
  home       => '/home/teleivo',
}

::vim::dotvim { '/home/teleivo':
  user    => 'teleivo',
  require => [
    Package['git', 'vim'],
    User['teleivo'],
  ]
}
