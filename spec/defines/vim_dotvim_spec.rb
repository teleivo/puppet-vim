require 'spec_helper'

describe 'vim::dotvim', :type => :define do
  context 'on Ubuntu 14.04 64bit' do
    $user = 'teleivo'
    $user_home = '/home/teleivo'
    $dotvim_path = $user_home + "/.vim"

    let(:title) { $user_home }

    let(:valid_required_params) do
      { 
        :user => $user,
      }
    end

    context 'with only required parameters given' do
      let :params do
        valid_required_params
      end
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
    end

    context 'with invalid parameters' do
      describe 'when user is not a string' do
        let :params do
          valid_required_params.merge({
            :user => true,
          })
        end
        it { should_not compile }
      end

      describe 'when user_home is not an absolute path' do
        let :params do
          valid_required_params.merge({
            :user_home => 'home/teleivo',
          })
        end
        it { should_not compile }
      end
    end
  end
end
