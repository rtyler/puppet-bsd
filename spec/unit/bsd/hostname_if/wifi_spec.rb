require 'puppet_x/bsd/hostname_if/wifi'

describe 'PuppetX::BSD::Hostname_if::Wifi' do
  describe 'validation' do
    it 'should fail if no config is supplied' do
      c = {}
      expect { PuppetX::BSD::Hostname_if::Wifi.new(c).content }.to raise_error
    end

    it "should raise an error if missing arguments" do
      c = {
        :network_name => 'myssid',
      }
      expect {
        PuppetX::BSD::Hostname_if::Wifi.new(c).content
      }.to raise_error(ArgumentError, /network_key.*required/)
    end

    it "should raise an error if unknown arguments" do
      c = {
        :network_name => 'myssid',
        :network_key => 'mykey',
        :random => '1',
      }
      expect {
        PuppetX::BSD::Hostname_if::Wifi.new(c).content
      }.to raise_error(ArgumentError, /unknown configuration item/)
    end
  end

  describe 'content' do
    it 'should support a full example' do
      c = {
        :network_name => 'myssid',
        :network_key => 'mykey',
      }
      expect(PuppetX::BSD::Hostname_if::Wifi.new(c).content).to match(/nwid myssid wpakey mykey/)
    end

    it 'should support a partial example' do
      c = {
        :network_name => 'myssid',
        :network_key => 'mykey',
        :address => '10.0.0.1/24',
      }
      expect(PuppetX::BSD::Hostname_if::Wifi.new(c).content).to match(/inet 10.0.0.1 255.255.255.0 NONE nwid myssid wpakey mykey/)
    end
  end
end
