#!/usr/bin/env ruby
require 'net/scp'
require 'logger'

username = ARGV[0]
password = ARGV[1]
host = ARGV[2]
src = ARGV[3]
dest = ARGV[4]

class UpLog
  def self.log
    if @logger.nil?
      @logger =Logger.new 'upload.log'
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
    end
    @logger
  end
end

Net::SCP.upload!(host, username, src, dest, ssh: { password: password }, recursive: true) do |ch, name, sent, total|
  UpLog.log.info "#{name}: #{sent}/#{total}"
end


Net::SCP.upload!(host, username, 'upload.log', '/home/admin/', ssh: { password: password }, recursive: true) do |ch, name, sent, total|
  puts "#{name}: #{sent}/#{total}"
end
