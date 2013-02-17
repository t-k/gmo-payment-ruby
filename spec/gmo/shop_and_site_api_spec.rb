require "spec_helper"

describe "GMO::Payment::ShopAndSiteAPI" do

  before(:each) do
    @service ||= GMO::Payment::ShopAndSiteAPI.new({
      :shop_id   => SPEC_CONF["shop_id"],
      :shop_pass => SPEC_CONF["shop_pass"],
      :site_id   => SPEC_CONF["site_id"],
      :site_pass => SPEC_CONF["site_pass"]
    })
  end

  it "should raise an ArgumentError if no options passed" do
    lambda {
      service = GMO::Payment::ShopAndSiteAPI.new()
    }.should raise_error(ArgumentError)
  end

  it "has an attr_reader for shop_id" do
    @service.shop_id.should == SPEC_CONF["shop_id"]
  end

  it "has an attr_reader for shop_pass" do
    @service.shop_pass.should == SPEC_CONF["shop_pass"]
  end

  it "has an attr_reader for site_id" do
    @service.site_id.should == SPEC_CONF["site_id"]
  end

  it "has an attr_reader for site_pass" do
    @service.site_pass.should == SPEC_CONF["site_pass"]
  end

  describe "#trade_card" do

    it "got error if missing options", :vcr do
      lambda {
        result = @service.trade_card()
      }.should raise_error
    end
  end

end