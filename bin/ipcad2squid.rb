#!/usr/bin/env ruby

class Ipcad2squid
  attr_reader :cmd1, :cmd2, :net, :ttime, :filename

  def initialize(options={})
    @cmd1     = options[:cmd1]     || 'netkit-rsh localhost sh ip accounting'
    @cmd2     = options[:cmd2]     || 'netkit-rsh localhost show ip accounting checkpoint'
    @net      = options[:net]      || '192.168.0'
    @filename = options[:filename] || '/var/log/squid/access.log'
    @ttime    = `#{@cmd1}`.split("\n").grep(/saved/) { |saved| saved.split.last }.first rescue '0'
  end

  def output
    # get all data for subnet
    accounting_data = `#{@cmd2}`.split("\n").grep(/#{@net}/)

    # parse and output data
    accounting_data.map do |raw_data|
      data = raw_data.split
      "#{@ttime}.000 1 #{data[1]} TCP_MISS/200 #{data[3]} CONNECT #{data[0]}:#{data[4]} - DIRECT/#{data[1]} -"
    end.join("\n")
  end

  def write_to_file
    File.open(@filename, "w") { |file| file.write(output) }
  end
end