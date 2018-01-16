require "spec_helper"

describe "GMO::Payment::SiteAPI" do

  before(:all) do
    @member_id = generate_id
  end

  before(:each) do
    @shop_site ||= GMO::Payment::ShopAndSiteAPI.new({
      :site_id   => SPEC_CONF["site_id"],
      :site_pass => SPEC_CONF["site_pass"],
      :shop_id   => SPEC_CONF["shop_id"],
      :shop_pass => SPEC_CONF["shop_pass"],
      :host      => SPEC_CONF["host"],
      :locale    => :ja

    })
    @service ||= GMO::Payment::SiteAPI.new({
      :site_id   => SPEC_CONF["site_id"],
      :site_pass => SPEC_CONF["site_pass"],
      :host      => SPEC_CONF["host"],
      :locale    => :ja

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
      result["MemberID"].nil?.should_not be_truthy
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
      result["MemberID"].nil?.should_not be_truthy
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
      result["MemberID"].nil?.should_not be_truthy
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
      result["MemberID"].nil?.should_not be_truthy

      result = @service.search_member({
        :member_id => member_id
      })
      result["MemberID"].nil?.should_not be_truthy
      result["MemberName"].nil?.should_not be_truthy
      (result["MemberName"].to_s == member_name).should be_truthy
      result["DeleteFlag"].nil?.should_not be_truthy
      (result["DeleteFlag"].to_i == 0).should be_truthy
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
      result["CardNo"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.save_card()
      }.should raise_error("Required member_id, card_no, expire were not provided.")
    end

    it "doesn't require card info if token is present", :vcr do
      member_id = SPEC_CONF["token_member_id"]
      token = SPEC_CONF["token"]
      result = @service.save_card({
        :member_id => member_id,
        :token     => token
      })
      result["CardNo"].nil?.should_not be_truthy
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
      result["CardSeq"].nil?.should_not be_truthy
      (result["CardSeq"].to_i == card_seq).should be_truthy
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
      result["CardSeq"].nil?.should_not be_truthy
      (result["CardSeq"].to_i == card_seq).should be_truthy
      result["DefaultFlag"].nil?.should_not be_truthy
      (result["DefaultFlag"].to_i == 0).should be_truthy
      result["CardName"].nil?.should_not be_truthy
      result["CardNo"].nil?.should_not be_truthy
      result["Expire"].nil?.should_not be_truthy
      (result["Expire"].to_s == expire).should be_truthy
      result["HolderName"].nil?.should_not be_truthy
      result["DeleteFlag"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_card()
      }.should raise_error("Required member_id, seq_mode were not provided.")
    end
  end

  describe "#search_card_detail_by_member_id" do
    it "gets data about card detail", :vcr do
      member_id = generate_id
      seq_mode = 0
      result = @service.search_card_detail_by_member_id({
        :member_id => member_id,
        :seq_mode  => seq_mode
      })
      result["CardNo"].nil?.should_not be_truthy
      result["Brand"].nil?.should_not be_truthy
      result["DomesticFlag"].nil?.should_not be_truthy
      result["IssuerCode"].nil?.should_not be_truthy
      result["DebitPrepaidFlag"].nil?.should_not be_truthy
      result["DebitPrepaidIssuerName"].nil?.should_not be_truthy
      result["ForwardFinal"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_card_detail_by_member_id()
      }.should raise_error("Required member_id, seq_mode were not provided.")
    end
  end

  describe "#search_brandtoken" do
    it "gets data about a brandtoken", :vcr do
      order_id = generate_id
      member_id = generate_id
      @shop_site.trade_brandtoken({
        :order_id  => order_id,
        :member_id => member_id
      })

      result = @service.search_brandtoken({
        :member_id => member_id,
        :seq_mode  => 0
      })
      result["TokenSeq"].nil?.should_not be true
      result["DefaultFlag"].nil?.should_not be true
      result["CardName"].nil?.should_not be true
      result["CardNoToken"].nil?.should_not be true
      result["Expire"].nil?.should_not be true
      result["HolderName"].nil?.should_not be true
      result["DeleteFlag"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_brandtoken()
      }.should raise_error("Required member_id, seq_mode were not provided.")
    end
  end

  describe "#delete_brandtoken" do
    it "gets data about a brandtoken", :vcr do
      order_id = generate_id
      member_id = generate_id
      @shop_site.trade_brandtoken({
        :order_id  => order_id,
        :member_id => member_id
      })

      result = @service.delete_brandtoken({
        :member_id => member_id,
        :seq_mode  => 0,
        :token_seq => 0
      })
      result["TokenSeq"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.delete_brandtoken()
      }.should raise_error('Required member_id, seq_mode, token_seq were not provided.')
    end
  end
end
