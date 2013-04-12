GMO
====
[![Gem Version](https://badge.fury.io/rb/gmo.png)](https://rubygems.org/gems/gmo)
[![Build Status](https://travis-ci.org/t-k/gmo-payment-ruby.png)](https://travis-ci.org/t-k/gmo-payment-ruby)

RubyからGMOペイメント(PGマルチペイメントサービス)のAPIを扱うためのGemです。

インストール方法
---

Install GMO as a gem:
```bash
gem install gmo
```

or add to your Gemfile:
```ruby
# Gemfile
gem "gmo"
```
and run bundle install to install the dependency.

TODO
---
* add supported APIs
* improve docs

使い方
---
```ruby
require 'gmo'
# setup
gmo = GMO::Payment::ShopAPI.new({:shop_id => "SHOP_ID", :shop_pass => "SHOP_PASS", :host => "foo.mul-pay.jp"})
#
option = {
  :order_id => 1,
  :job_cd   => "AUTH",
  :amount   => 100
}
result = gmo.entry_tran(option)
```
その他、詳細な使い方は<a href="https://github.com/t-k/gmo-payment-ruby/wiki/_pages">wiki</a>で説明しています。

Contributors
---
Patches contributed by [those people](https://github.com/t-k/gmo-payment-ruby/contributors).