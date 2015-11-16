require 'spec_helper'

describe 'vim::dotvim', :type => :define do
  context 'on Ubuntu 14.04 64bit' do
    $user = 'teleivo'
    $user_home = '/home/teleivo'
    $dotvim_path = $user_home + "/.vim"

    let(:title) { $user_home }

    let(:params) {
      { 
        'user' => $user,
      }
    }

    it { is_expected.to contain_vcsrepo($dotvim_path).with(
        'ensure'   => 'present',
        'provider' => 'git',
        'source'   => 'https://github.com/teleivo/dotvim.git',
        'user'     => $user,
      )
    }

    it { is_expected.to contain_file($user_home + "/.vimrc").with(
        'ensure' => 'link',
        'owner'  => $user,
        'target' => $dotvim_path + "/vimrc",
      )
    }

    it 'should not compile when user is not a string' do
      params.merge!({'user' => true})
      should_not compile
    end

    it 'should not compile when user_home is not an absolute path' do
      params.merge!({'user_home' => 'home/teleivo'})
      should_not compile
    end
  end
end
