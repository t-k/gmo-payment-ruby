GMO
====
[![Gem Version](https://badge.fury.io/rb/gmo.png)](https://rubygems.org/gems/gmo)
[![Build Status](https://travis-ci.org/t-k/gmo-payment-ruby.png)](https://travis-ci.org/t-k/gmo-payment-ruby)

GMO is a Ruby client library for the GMO Payment Platform, supporting the PG Multi Payment API, exec transactions, register users, and so on.

Installation
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

Usage
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
More documentation available <a href="https://github.com/t-k/gmo-payment-ruby/wiki/_pages">on the wiki</a>.

Contributors
---
Patches contributed by [those people](https://github.com/t-k/gmo-payment-ruby/contributors).