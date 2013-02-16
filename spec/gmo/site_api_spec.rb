require "spec_helper"

describe "GMO::Payment::SiteAPI" do

  before(:each) do
    @service ||= GMO::Payment::SiteAPI.new({
      :site_id   => SPEC_CONF["site_id"],
      :site_pass => SPEC_CONF["site_pass"]
    })
  end

  it "has an attr_reader for site_id" do
    @service.site_id.should == SPEC_CONF["site_id"]
  end

  it "has an attr_reader for site_pass" do
    @service.site_pass.should == SPEC_CONF["site_pass"]
  end

  describe "#save_member" do
    it "gets data about a transaction", :vcr do
      member_name = "John Smith"
      result = @service.save_member({
        :member_id => 100,
        :member_name => member_name
      })
      result["MemberID"].nil?.should_not be_true
    end
  end

  describe "#update_member" do
    it "gets data about a transaction", :vcr do
      member_name = "John Smith2"
      result = @service.update_member({
        :member_id => 100,
        :member_name => member_name
      })
      result["MemberID"].nil?.should_not be_true
    end
  end

end
