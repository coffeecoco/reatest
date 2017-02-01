# -*- mode: ruby -*-

dir = File.dirname(File.expand_path(__FILE__))

require 'yaml'
require "#{dir}/coffeecoco/ruby/deep_merge.rb"
require "#{dir}/coffeecoco/ruby/to_bool.rb"
require "#{dir}/coffeecoco/ruby/puppet.rb"

configValues = YAML.load_file("#{dir}/coffeecoco/config.yaml")

provider = ENV['VAGRANT_DEFAULT_PROVIDER'] ? ENV['VAGRANT_DEFAULT_PROVIDER'] : 'local'
if File.file?("#{dir}/coffeecoco/config-#{provider}.yaml")
  custom = YAML.load_file("#{dir}/coffeecoco/config-#{provider}.yaml")
  configValues.deep_merge!(custom)
end

if File.file?("#{dir}/coffeecoco/config-custom.yaml")
  custom = YAML.load_file("#{dir}/coffeecoco/config-custom.yaml")
  configValues.deep_merge!(custom)
end

data = configValues['vagrantfile']

Vagrant.require_version '>= 1.8.1'

Vagrant.configure('2') do |config|
  eval File.read("#{dir}/coffeecoco/vagrant/Vagrantfile-#{data['target']}")
end

