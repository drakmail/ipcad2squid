require 'ipcad2squid'

CMD1 = 'cat spec/input1.txt'
CMD2 = 'cat spec/input2.txt'

describe Ipcad2squid do
  subject(:script) {Ipcad2squid.new(:cmd1 => CMD1, :cmd2 => CMD2)}

  context 'Passing commands' do
    subject(:script) {Ipcad2squid.new(:cmd1 => CMD1, :cmd2 => CMD2, :filename => 'output.txt')}
    its(:cmd1) { should == CMD1 }
    its(:cmd2) { should == CMD2 }
    its(:filename) { should == 'output.txt' }
  end

  context 'Default commands' do
    subject(:script) {Ipcad2squid.new}
    its(:cmd1) { should == 'netkit-rsh localhost sh ip accounting' }
    its(:cmd2) { should == 'netkit-rsh localhost show ip accounting checkpoint' }
    its(:filename) { should == '/var/log/squid/access.log' }
  end

  context 'Integration testing' do
    its(:ttime) { should == '1357223673' }
    its(:output) { should include('1357223673.000 1 192.168.0.4 TCP_MISS/200 77 CONNECT 185.2.107.224: - DIRECT/192.168.0.4 -') }
    its(:output) { should include('1357223673.000 1 192.168.0.4 TCP_MISS/200 55490 CONNECT 46.119.234.141: - DIRECT/192.168.0.4 -') }
  end

  context 'File IO' do
    it 'shoud write output to file' do
      file = mock('file')
      File.should_receive(:open).with("/var/log/squid/access.log", "a").and_yield(file)
      file.should_receive(:write).with(script.output)
      script.write_to_file
    end
  end

end