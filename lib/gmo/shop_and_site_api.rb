# coding: utf-8

# A client for the GMO Payment API.
#
# example
# gmo = GMO::Payment::ShopAndSiteAPI.new({
#   site_id:     "foo",
#   site_pass:   "bar",
#   shop_id:     "baz",
#   shop_pass:   "bax",
#   host:        "p01.mul-pay.jp"
# })
module GMO
  module Payment

    module ShopAndSiteAPIMethods
      def initialize(options = {})
        @shop_id   = options[:shop_id]
        @shop_pass = options[:shop_pass]
        @site_id   = options[:site_id]
        @site_pass = options[:site_pass]
        @host      = options[:host]
        unless @site_id && @site_pass && @shop_id && @shop_pass && @host
          raise ArgumentError, "Initialize must receive a hash with :site_id, :site_pass, :shop_id, :shop_pass and either :host! (received #{options.inspect})"
        end
      end
      attr_reader :shop_id, :shop_pass, :site_id, :site_pass, :host

      # 2.17.2.1.決済後カード登録
      # 指定されたオーダーID の取引に使用したカードを登録します。
      ### @return ###
      # CardSeq
      # CardNo
      # Forward
      def trade_card(options = {})
        name = "TradedCard.idPass"
        required = [:order_id, :member_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # MemberID
      # OrderID
      # DefaultFlag
      # SeqMode
      ### @return ###
      # TokenSeq
      # CardNoToken
      # Forward
      ### example ###
      # gmo.trade_brandtoken({
      #   member_id: 'mem10001',
      #   order_id: 'ord10001'
      # })
      # => {"TokenSeq"=>"0", "CardNoToken"=>"*************111", "Forward"=>"2a99663"}
      def trade_brandtoken(options = {})
        name = "TradedBrandtoken.idPass"
        required = [:order_id, :member_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # TokenType
      # Token
      # MemberID
      # SeqMode
      # TokenSeq
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # Status
      # OrderID
      # Forward
      # Approve
      # TranID
      # TranDate
      # ClientField1
      # ClientField2
      # ClientField3
      ### example ###
      # gmo.exec_tran_brandtoken({
      #   order_id: "597ae8c36120b23a3c00014e",
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   token_type: :apple_pay,
      #   token: <Base64 encoded payment data>,
      #   member_id: "mem10001"
      # })
      # => {"Status"=>"CAPTURE", "OrderID"=>"597ae8c36120b23a3c00014e", "Forward"=>"2a99663", "Approve"=>"5487394", "TranID"=>"1707281634111111111111771216", "TranDate"=>"20170728163453", "ClientField1"=>"Custom field value 1", "ClientField2"=>"Custom field value 2", "ClientField3"=>"Custom field value 3"}
      def exec_tran_brandtoken(options = {})
        name = "ExecTranBrandtoken.idPass"
        options[:token_type] = GMO::Const::TOKEN_TYPES_MAP[options[:token_type]]
        required = [:access_id, :access_pass, :member_id, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # MemberID
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # ShopID
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # NextChargeDate
      # Method
      # SiteID
      # MemberID
      # CardNo
      # Expire
      def register_recurring_credit(options)
        name = "RegisterRecurringCredit.idPass"
        required = [:recurring_id, :amount, :charge_day, :member_id]
        options[:regist_type] = 1
        assert_required_options(required, options)
        post_request name, options
      end

      ### @param ###
      # RecurringID
      # Amount
      # Tax
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # MemberID
      # PrintStr
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # ShopID
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # NextChargeDate
      # Method
      # MemberID
      # PrintStr
      def register_recurring_accounttrans(options)
        name = "RegisterRecurringAccounttrans.idPass"
        required = [:recurring_id, :amount, :member_id, :print_str]
        assert_required_options(required, options)
        post_request name, options
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          args.merge!({
            "ShopID"   => @shop_id,
            "ShopPass" => @shop_pass,
            "SiteID"   => @site_id,
            "SitePass" => @site_pass
          })
          api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response)
            end
          end
        end

    end
  end
end
