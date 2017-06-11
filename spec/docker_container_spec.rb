require 'spec_helper'

describe 'docker container' do
  before(:all) do
    set :os, family: :ubuntu
    set :backend, :docker
    set :docker_image, image.id
  end

  describe 'sshd' do
    describe package('openssh-server') do
      it { is_expected.to be_installed }
    end

    describe file('/var/run/sshd') do
      it { should be_directory }
    end

    describe file('/etc/pam.d/sshd') do
      its(:content) { should match /session optional pam_loginuid\.so/ }
      its(:content) { should_not match /[^#]session\s*optional\s*pam_motd\.so/ }
    end

    describe file('/etc/ssh/sshd_config') do
      its(:content) { should match 'AuthorizedKeysFile /etc/ssh/%u/authorized_keys' }
    end

    describe process('sshd') do
      it { should be_running }
    end

    describe port(22) do
      it { should be_listening.on('0.0.0.0').with('tcp') }
    end
  end

  describe 'rsync' do
    describe package('rsync') do
      it { is_expected.to be_installed }
    end

    describe group('rsync') do
      it { should exist }
      it { should have_gid 1000 }
    end

    describe user('rsync') do
      it { should exist }
      it { should have_uid 1000 }
      it { should belong_to_primary_group 'rsync' }
      it { should have_home_directory '/rsync' }
    end

    describe file('/etc/ssh/rsync') do
      it { should be_directory }
      it { should be_owned_by 'rsync' }
      it { should be_grouped_into 'rsync' }
    end
  end
end
