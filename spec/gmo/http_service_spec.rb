require 'spec_helper'

class FakeHTTPService
  include GMO::HTTPService
end

describe "GMO::HTTPService" do

  describe "common methods" do
    describe "server" do
      it "should return the host" do
        FakeHTTPService.server(:host => SPEC_CONF["host"]).should == SPEC_CONF["host"]
      end
    end

  end

end