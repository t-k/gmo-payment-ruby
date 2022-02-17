# coding: utf-8

# A client for the GMO Payment API.
#
# example
# gmo = GMO::Payment::ShopAPI.new({
#   shop_id:     "foo",
#   shop_pass:   "bar",
#   host:        "mul-pay.com",
#   locale:      "ja"

# })
# result = gmo.post_request("EntryTran.idPass", options)
module GMO
  module Payment

    module ShopAPIMethods

      def initialize(options = {})
        @shop_id   = options[:shop_id]
        @shop_pass = options[:shop_pass]
        @host      = options[:host]
        @locale    = options.fetch(:locale, GMO::Const::DEFAULT_LOCALE)
        unless @shop_id && @shop_pass && @host
          raise ArgumentError, "Initialize must receive a hash with :shop_id, :shop_pass and either :host! (received #{options.inspect})"
        end
      end
      attr_reader :shop_id, :shop_pass, :host, :locale

      ## 2.1.2.1.取引登録
      # これ以降の決済取引で必要となる取引 ID と取引パスワードの発行を行い、取引を開始します。
      # ItemCode
      # Tax
      # TdFlag
      # TdTenantName
      ### @return ###
      # AccessID
      # AccessPass
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.entry_tran({
      #   order_id: 100,
      #   job_cd: "AUTH",
      #   amount: 100
      # })
      # {"AccessID"=>"a41d83f1f4c908baeda04e6dc03e300c", "AccessPass"=>"d72eca02e28c88f98b9341a33ba46d5d"}
      def entry_tran(options = {})
        name = "EntryTran.idPass"
        required = [:order_id, :job_cd]
        required << :amount if options[:job_cd] && options[:job_cd] != "CHECK"
        assert_required_options(required, options)
        post_request name, options
      end

      # 【コンビニ払い】
      #  2.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_cvs(options = {})
        name = "EntryTranCvs.idPass"
        required = [:order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【Pay-easy決済】
      #  5.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_pay_easy(options = {})
        name = "EntryTranPayEasy.idPass"
        required = [:order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【LINE Pay決済】
      #  20.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_linepay(options = {})
        name = "EntryTranLinepay.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # OrderID
      # JobCd
      # Amount
      # ItemCode
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      ### example ###
      # gmo.entry_tran_brandtoken({
      #   order_id: "ord12345",
      #   job_cd: "AUTH",
      #   item_code: "1000001",
      #   tax: "0001001",
      #   amount: 100
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744"}
      def entry_tran_brandtoken(options = {})
        name = "EntryTranBrandtoken.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # OrderID
      # JobCd
      # Amount
      # ItemCode
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      ### example ###
      # gmo.entry_tran_rakuten_id({
      #   order_id: "ord12345",
      #   job_cd: "AUTH",
      #   item_code: "1000001",
      #   tax: "0001001",
      #   amount: 100
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744"}
      def entry_tran_rakuten_id(options = {})
        name = "EntryTranRakutenId.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # OrderID
      # JobCd
      # Amount
      # ItemCode
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      ### example ###
      # gmo.entry_tran_docomo({
      #   order_id: "ord12345",
      #   job_cd: "AUTH",
      #   item_code: "1000001",
      #   tax: "0001001",
      #   amount: 100
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744"}
      def entry_tran_docomo(options = {})
        name = "EntryTranDocomo.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.2.2.2.決済実行
      # 指定されたサイトに会員を登録します。
      # return
      # ACS
      # OrderID
      # Forward
      # Method
      # PayTimes
      # Approve
      # TranID
      # TranDate
      # CheckString
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # ACS
      # OrderID
      # Forward
      # Method
      # PayTimes
      # Approve
      # TranID
      # CheckString
      # ClientField1
      # ClientField2
      # ClientField3
      ### example ###
      # gmo.exec_tran({
      #   order_id:      100,
      #   access_id:    "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:  "d72eca02e28c88f98b9341a33ba46d5d",
      #   method:        1,
      #   pay_times:     1,
      #   card_no:       "4111111111111111",
      #   expire:        "1405", #format YYMM
      #   client_field_1: "client_field1"
      # })
      # {"ACS"=>"0", "OrderID"=>"100", "Forward"=>"2a99662", "Method"=>"1", "PayTimes"=>"", "Approve"=>"6294780", "TranID"=>"1302160543111111111111192829", "TranDate"=>"20130216054346", "CheckString"=>"3e455a2168fefc90dbb7db7ef7b0fe82", "ClientField1"=>"client_field1", "ClientField2"=>"", "ClientField3"=>""}
      def exec_tran(options = {})
        name = "ExecTran.idPass"
        if options[:client_field_1] || options[:client_field_2] || options[:client_field_3]
          options[:client_field_flg] = "1"
        else
          options[:client_field_flg] = "0"
        end
        options[:device_category] = "0"

        # args = {
        #   "AccessID"        => options[:access_id],
        #   "AccessPass"      => options[:access_pass],
        #   "OrderID"         => options[:order_id],
        #   "Method"          => options[:method],
        #   "PayTimes"        => options[:pay_times],
        #   "CardNo"          => options[:card_no],
        #   "Expire"          => options[:expire],
        #   "HttpAccept"      => options[:http_accept],
        #   "HttpUserAgent"   => options[:http_ua],
        #   "DeviceCategory"  => "0",
        #   "ClientField1"    => options[:client_field_1],
        #   "ClientField2"    => options[:client_field_2],
        #   "ClientField3"    => options[:client_field_3],
        #   "ClientFieldFlag" => client_field_flg
        # }
        if options[:token].nil?
          required = [:access_id, :access_pass, :order_id, :card_no, :expire]
        else
          required = [:access_id, :access_pass, :token]
        end
        assert_required_options(required, options)
        post_request name, options
      end

      # 2.2.2.4 認証後決済実行
      def secure_tran(options = {})
        name = "SecureTran.idPass"
        required = [:pa_res, :md]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【コンビニ払い】
      # 2.1.2.2. 決済実行
      # お客様が入力した情報で後続の決済センターと通信を行い決済を実施し、結果を返します。
      def exec_tran_cvs(options = {})
        name = "ExecTranCvs.idPass"
        required = [:access_id, :access_pass, :order_id, :convenience, :customer_name, :customer_kana, :tel_no, :receipts_disp_11, :receipts_disp_12, :receipts_disp_13]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【Pay-easy決済】
      # 5.1.2.2. 決済実行
      # お客様が入力した情報で後続の決済センターと通信を行い決済を実施し、結果を返します。
      def exec_tran_pay_easy(options = {})
        name = "ExecTranPayEasy.idPass"
        required = [:access_id, :access_pass, :order_id, :customer_name, :customer_kana, :tel_no, :receipts_disp_11, :receipts_disp_12, :receipts_disp_13]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【LINE Pay決済】
      # 20.1.2.2. 決済実行
      def exec_tran_linepay(options = {})
        name = "ExecTranLinepay.idPass"
        required = [:access_id, :access_pass, :order_id, :ret_url, :error_rcv_url, :product_name]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【楽天ペイ決済】
      # 18.1.2.2. 決済実行
      def exec_tran_rakuten_id(options = {})
        name = "ExecTranRakutenId.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【ドコモ払い決済】
      # 18.1.2.2. 決済実行
      def exec_tran_docomo(options = {})
        name = "ExecTranDocomo.idPass"
        required = [:access_id, :access_pass, :order_id]
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
      #   seq_mode: "1",
      #   token_seq: 1001,
      #   client_field_1: "Custom field value 1",
      #   client_field_2: "Custom field value 2",
      #   client_field_3: "Custom field value 3"
      # })
      # => {"Status"=>"CAPTURE", "OrderID"=>"597ae8c36120b23a3c00014e", "Forward"=>"2a99663", "Approve"=>"5487394", "TranID"=>"1707281634111111111111771216", "TranDate"=>"20170728163453", "ClientField1"=>"Custom field value 1", "ClientField2"=>"Custom field value 2", "ClientField3"=>"Custom field value 3"}
      def exec_tran_brandtoken(options = {})
        name = "ExecTranBrandtoken.idPass"
        options[:token_type] = GMO::Const::TOKEN_TYPES_MAP[options[:token_type]]
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.14.2.1.決済変更
      # 仮売上の決済に対して実売上を行います。尚、実行時に仮売上時との金額チェックを行います。
      # /payment/AlterTran.idPass
      # ShopID
      # ShopPass
      # AccessID 取引ID
      # AccessPass 取引パスワード
      # JobCd 処理区分 "SALES"
      # Amount 利用金額
      ### @return ###
      # AccessID
      # AccessPass
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.alter_tran({
      #   access_id:    "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:  "d72eca02e28c88f98b9341a33ba46d5d",
      #   job_cd: "SALES",
      #   amount: 100
      # })
      # {"AccessID"=>"381d84ae4e6fc37597482573a9569f10", "AccessPass"=>"cc0093ca8758c6616fa0ab9bf6a43e8d", "Forward"=>"2a99662", "Approve"=>"6284199", "TranID"=>"1302140555111111111111193536", "TranDate"=>"20130215110651"}
      def alter_tran(options = {})
        name = "AlterTran.idPass"
        required = [:access_id, :access_pass, :job_cd]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.15.2.1.金額変更
      # 決済が完了した取引に対して金額の変更を行います。
      ### @return ###
      # AccessID
      # AccessPass
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.change_tran({
      #   access_id:    "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:  "d72eca02e28c88f98b9341a33ba46d5d",
      #   job_cd: "CAPTURE",
      #   amount: 100
      # })
      def change_tran(options = {})
        name = "ChangeTran.idPass"
        required = [:access_id, :access_pass, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # JobCd
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.change_tran_brandtoken({
      #   access_id: "21170701482c86c3b88ff72b83bfd363",
      #   access_pass: "51f36feba120de1e6e29532e5a3a5e3e",
      #   order_id: "ord10001",
      #   job_cd: "CAPTURE",
      #   amount: 2000
      # })
      # => {"AccessID"=>"21170701482c86c3b88ff72b83bfd363", "AccessPass"=>"51f36feba120de1e6e29532e5a3a5e3e", "Status"=>"CAPTURE", "Forward"=>"2a99663", "Approve"=>"5538477", "TranID"=>"1707311633111111111111771224", "TranDate"=>"20170731163343"}
      def change_tran_brandtoken(options = {})
        name = "ChangeTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.void_tran_brandtoken({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   order_id: "597ae8c36120b23a3c00014e"
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744", "Status"=>"VOID", "Forward"=>"2a99663", "Approve"=>"5537590", "TranID"=>"1707311610111111111111771219", "TranDate"=>"20170731161007"}
      def void_tran_brandtoken(options = {})
        name = "VoidTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.sales_tran_brandtoken({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   order_id: "597ae8c36120b23a3c00014e",
      #   amount: 1000,
      #   tax: "0001001"
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744", "Status"=>"SALES", "Forward"=>"2a99663", "Approve"=>"5537883", "TranID"=>"1707311620111111111111771220", "TranDate"=>"20170731162256"}
      def sales_tran_brandtoken(options = {})
        name = "SalesTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.refund_tran_brandtoken({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   order_id: "597ae8c36120b23a3c00014e",
      #   amount: 1000,
      #   tax: "0001001"
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744", "Status"=>"RETURN", "Forward"=>"2a99663", "Approve"=>"5537883", "TranID"=>"1707311620111111111111771220", "TranDate"=>"20170731162256"}
      def refund_tran_brandtoken(options = {})
        name = "RefundTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【コンビニ払い】
      ## 2.2.2.1. 支払停止
      # コンビニ決済センターとの通信を行い取引の支払停止処理を行います。
      def cvs_cancel(options = {})
        name = "CvsCancel.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.16.2.1.取引状態参照
      # 指定したオーダーID の取引情報を取得します。
      def search_trade(options = {})
        name = "SearchTrade.idPass"
        required = [:order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      # 13.1.2.1.取引状態参照
      # 指定したオーダーIDの取引情報を取得します。
      ### @params ###
      # OrderID
      # PayType
      ### @return ###
      # OrderID
      # Status
      # ProcessDate
      # JobCd
      # AccessID
      # AccessPass
      # ItemCode
      # Amount
      # Tax
      # SiteID
      # MemberID
      # CardNoToken
      # Expire
      # Method
      # PayTimes
      # Forward
      # TranID
      # Approve
      # ClientField1
      # ClientField2
      # ClientField3
      # PayType
      ### example ###
      # gmo.search_trade_multi({
      #   order_id: '598066176120b2235300020b',
      #   pay_type: 27
      # })
      # => {"OrderID"=>"598066176120b2235300020b", "Status"=>"CAPTURE", "ProcessDate"=>"20170801202929", "JobCd"=>"CAPTURE", "AccessID"=>"228fc5bc02da46943300c12706d325a2", "AccessPass"=>"090a50ec2f77d92184a18018f07906e5", "ItemCode"=>"0000990", "Amount"=>"557", "Tax"=>"0", "SiteID"=>"", "MemberID"=>"", "CardNoToken"=>"************1111", "Expire"=>"2212", "Method"=>"1", "PayTimes"=>"", "Forward"=>"2a99663", "TranID"=>"1708012029111111111111771228", "Approve"=>"5689128", "ClientField1"=>"", "ClientField2"=>"", "ClientField3"=>"", "PayType"=>"27"}
      def search_trade_multi(options = {})
        name = "SearchTradeMulti.idPass"
        required = [:order_id, :pay_type]
        assert_required_options(required, options)
        post_request name, options
      end

      ###################################################
      # 3DS2.0 対応
      ###################################################

      # 4.3.1.7 3DS2.0認証実行(Tds2Auth)
      # DS2.0認証を実行します。
      # 3DS2.0認証初期化URL(RedirectUrl)のコールバックを受けたタイミングで本処理を実行してください。
      def tds2_auth(options = {})
        name = "Tds2Auth.idPass"
        required = [:access_id, :access_pass, :tds2_param]
        assert_required_options(required, options)
        post_request name, options
      end

      # 4.3.1.8 3DS2.0認証結果取得(Tds2Result)
      # 3DS2.0認証の最終的な認証結果を取得します。
      # 3DS2.0認証チャレンジURL(ChallengeUrl)のコールバックを受けたタイミングで本処理を実行してください。
      def tds2_result(options = {})
        name = "Tds2Result.idPass"
        required = [:access_id, :access_pass]
        assert_required_options(required, options)
        post_request name, options
      end

      # 4.3.1.12 3DS2.0認証後決済実行(SecureTran2)
      # 3DS2.0サービスの結果を解析し、その情報を使用してカード会社と通信を行い決済を実施して結果を返します。
      def secure_tran_2(options = {})
        name = "SecureTran2.idPass"
        required = [:access_id, :access_pass]
        assert_required_options(required, options)
        post_request name, options
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          args.merge!({ "ShopID" => @shop_id, "ShopPass" => @shop_pass })
          api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response, locale)
            end
          end
        end

    end

  end
end
