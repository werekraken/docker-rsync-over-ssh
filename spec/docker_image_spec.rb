require 'spec_helper'

describe 'docker image' do
  before(:all) do
    set :backend, :exec
  end

  describe 'Docker image' do
    subject { docker_image(image.id) }
    it { should exist }
  end

  describe 'Docker image' do
    subject { docker_image(image.id) }
    its(['Architecture'])        { should eq 'amd64' }
    its(['Config.ExposedPorts']) { should include '22/tcp' }
    its(['Config.Cmd'])          { should include '/usr/sbin/sshd' }
  end
end
