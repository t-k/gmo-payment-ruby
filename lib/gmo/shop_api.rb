# coding: utf-8

# A client for the GMO Payment API.
#
# example
# gmo = GMO::Payment::ShopAPI.new({
#   shop_id:     "foo",
#   shop_pass:   "bar",
#   development:  true
# })
# result = gmo.post_request("EntryTran.idPass", options)
# init
# gmo = GMO::Payment::ShopAPI.new({
#         shop_pass: "7w74n3aw",
#         development: true})
module GMO
  module Payment

    module ShopAPIMethods

      def initialize(options = {})
        @shop_id     = options[:shop_id]
        @shop_pass   = options[:shop_pass]
        @development = options[:development] || true
        unless @shop_id && @shop_pass
          raise ArgumentError, "Initialize must receive a hash with :shop_id and either :shop_pass! (received #{options.inspect})"
        end
      end
      attr_reader :shop_id, :shop_pass, :development

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
        args = {
          "OrderID"  => options[:order_id],
          "JobCd"    => options[:job_cd],
          "Amount"   => options[:amount]
        }
        post_request name, args
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
      #   client_field1: "client_field1"
      # })
      # {"ACS"=>"0", "OrderID"=>"100", "Forward"=>"2a99662", "Method"=>"1", "PayTimes"=>"", "Approve"=>"6294780", "TranID"=>"1302160543111111111111192829", "TranDate"=>"20130216054346", "CheckString"=>"3e455a2168fefc90dbb7db7ef7b0fe82", "ClientField1"=>"client_field1", "ClientField2"=>"", "ClientField3"=>""}
      def exec_tran(options = {})
        name = "ExecTran.idPass"
        if options[:client_field1] || options[:client_field2] || options[:client_field3]
          client_field_flg = "1"
        else
          client_field_flg = "0"
        end
        args = {
          "AccessID"        => options[:access_id],
          "AccessPass"      => options[:access_pass],
          "OrderID"         => options[:order_id],
          "Method"          => options[:method],
          "PayTimes"        => options[:pay_times],
          "CardNo"          => options[:card_no],
          "Expire"          => options[:expire],
          "HttpAccept"      => options[:http_accept],
          "HttpUserAgent"   => options[:http_ua],
          "DeviceCategory"  => "0",
          "ClientField1"    => options[:client_field1],
          "ClientField2"    => options[:client_field2],
          "ClientField3"    => options[:client_field3],
          "ClientFieldFlag" => client_field_flg
        }
        post_request name, args
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
        args = {
          "AccessID"   => options[:access_id],
          "AccessPass" => options[:access_pass],
          "JobCd"      => options[:job_cd] || "SALES",
          "Amount"     => options[:amount]
        }
        post_request name, args
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
      #   JobCd: 100,
      #   Amount: 100
      # })
      def change_tran(options = {})
        name = "ChangeTran.idPass"
        args = {
          "AccessID"   => options[:access_id],
          "AccessPass" => options[:access_pass],
          "JobCd"      => options[:job_cd],
          "Amount"     => options[:amount]
        }
        post_request name, args
      end

      ## 2.16.2.1.取引状態参照
      # 指定したオーダーID の取引情報を取得します。
      def search_trade(options = {})
        name = "SearchTrade.idPass"
        args = {
          "OrderID" => options[:order_id]
        }
        post_request name, args
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          args.merge!({ "ShopID" => @shop_id, "ShopPass" => @shop_pass })
          response = api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response)
            end
          end
          response
        end

    end

  end
end