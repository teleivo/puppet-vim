# puppet-vim

[![Build Status](https://secure.travis-ci.org/teleivo/puppet-vim.png?branch=master)](https://travis-ci.org/teleivo/puppet-vim)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with vim](#setup)
    * [Beginning with vim](#beginning-with-vim)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Defines](#defines)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development](#development)

## Module Description

The vim module configures vim via a .vim stored in a vcs repository.

## Setup

### Beginning with vim

The quickest way to get vim set up is to apply a manifest like this one:

```puppet
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
```

## Reference

### Defines

#### dotvim::vim
~~~
vim::dotvim { '/home/teleivo':
  user      => 'teleivo',
  require   => User['teleivo'],
}
~~~
##### `user`

*Required.* Specifies the user as which .vim directory is cloned.
Valid options: string.

##### `user_home`

The user home path where .vim directory is cloned and .vimrc symlink to .vim/vimrc is created.
Valid options: string containing an absolute path.
Defaults to $title.

## Limitations

This module only deploys a .vim directory from repository [teleivo/dotvim](https://github.com/teleivo/dotvim).  
This module is currently only tested on Ubuntu 14.04 64bit.  

## Development

Please feel free to open pull requests!

### Running tests
This project contains tests for [rspec-puppet](http://rspec-puppet.com/) to
verify functionality.

To install all dependencies for the testing environment:
```bash
sudo gem install bundler
bundle install
```

To run tests, lint and syntax checks once:
```bash
bundle exec rake test
```

To run the tests on any change of puppet files in the manifests folder:
```bash
bundle exec guard
```

