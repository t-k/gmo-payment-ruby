require "spec_helper"

describe "GMO::Payment::SiteAPI" do

  before(:all) do
    @member_id = generate_id
  end

  before(:each) do
    @service ||= GMO::Payment::SiteAPI.new({
      :site_id   => SPEC_CONF["site_id"],
      :site_pass => SPEC_CONF["site_pass"],
      :host      => SPEC_CONF["host"]
    })
  end

  it "should raise an ArgumentError if no options passed" do
    lambda {
      service = GMO::Payment::SiteAPI.new()
    }.should raise_error(ArgumentError)
  end

  it "has an attr_reader for site_id" do
    @service.site_id.should == SPEC_CONF["site_id"]
  end

  it "has an attr_reader for site_pass" do
    @service.site_pass.should == SPEC_CONF["site_pass"]
  end

  it "has an attr_reader for host" do
    @service.host.should == SPEC_CONF["host"]
  end

  describe "#save_member" do
    it "gets data about a transaction", :vcr do
      member_name = "John Smith"
      result = @service.save_member({
        :member_id => @member_id,
        :member_name => member_name
      })
      result["MemberID"].nil?.should_not be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.save_member()
      }.should raise_error("Required member_id were not provided.")
    end
  end

  describe "#update_member" do
    it "gets data about a transaction", :vcr do
      member_id = @member_id
      member_name = "John Smith2"
      result = @service.update_member({
        :member_id => member_id,
        :member_name => member_name
      })
      result["MemberID"].nil?.should_not be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.update_member()
      }.should raise_error("Required member_id were not provided.")
    end
  end

  describe "#delete_member" do
    it "gets data about a member", :vcr do
      member_id = generate_id
      member_name = "John Smith"
      result = @service.save_member({
        :member_id => member_id,
        :member_name => member_name
      })
      result = @service.delete_member({
        :member_id => member_id
      })
      result["MemberID"].nil?.should_not be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.delete_member()
      }.should raise_error("Required member_id were not provided.")
    end
  end

  describe "#search_member" do
    it "gets data about a member", :vcr do
      member_name = "John Smith"
      member_id = generate_id
      result = @service.save_member({
        :member_id => member_id,
        :member_name => member_name
      })
      result["MemberID"].nil?.should_not be_true

      result = @service.search_member({
        :member_id => member_id
      })
      result["MemberID"].nil?.should_not be_true
      result["MemberName"].nil?.should_not be_true
      (result["MemberName"].to_s == member_name).should be_true
      result["DeleteFlag"].nil?.should_not be_true
      (result["DeleteFlag"].to_i == 0).should be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_member()
      }.should raise_error("Required member_id were not provided.")
    end
  end

  describe "#save_card" do
    it "gets data about a card", :vcr do
      member_id = @member_id
      card_no = "4111111111111111"
      expire = "1405"
      result = @service.save_card({
        :member_id => member_id,
        :card_no   => card_no,
        :expire    => expire
      })
      result["CardNo"].nil?.should_not be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.save_card()
      }.should raise_error("Required member_id, card_no, expire were not provided.")
    end
  end

  describe "#delete_card" do
    it "gets data about a card", :vcr do
      member_id = @member_id
      card_seq = 0
      result = @service.delete_card({
        :member_id => member_id,
        :card_seq   => card_seq
      })
      result["CardSeq"].nil?.should_not be_true
      (result["CardSeq"].to_i == card_seq).should be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.delete_card()
      }.should raise_error("Required member_id, card_seq were not provided.")
    end
  end

  describe "#search_card" do
    it "gets data about a card", :vcr do
      member_id = generate_id
      card_no = "4111111111111112"
      expire = "1405"
      result = @service.save_card({
        :member_id => member_id,
        :card_no   => card_no,
        :expire    => expire
      })
      card_seq = 0
      seq_mode = 0
      result = @service.search_card({
        :member_id => member_id,
        :card_seq  => card_seq,
        :seq_mode  => seq_mode
      })
      result["CardSeq"].nil?.should_not be_true
      (result["CardSeq"].to_i == card_seq).should be_true
      result["DefaultFlag"].nil?.should_not be_true
      (result["DefaultFlag"].to_i == 0).should be_true
      result["CardName"].nil?.should_not be_true
      result["CardNo"].nil?.should_not be_true
      result["Expire"].nil?.should_not be_true
      (result["Expire"].to_s == expire).should be_true
      result["HolderName"].nil?.should_not be_true
      result["DeleteFlag"].nil?.should_not be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_card()
      }.should raise_error("Required member_id, seq_mode were not provided.")
    end
  end

end
