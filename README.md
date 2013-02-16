GMO
====
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

Overview
---

TODO
---
* add tests
* set production server
* improve docs

Issues
---

Usage
---
```ruby
require 'gmo'
# setup
gmo = GMO::Payment::ShopAPI.new({:shop_id => "SHOP_ID", :shop_pass => "SHOP_PASS"})
#
option = {
  :order_id => 1,
  :job_cd   => "AUTH",
  :amount   => 100
}
result = gmo.entry_tran(option)
```

Authors and Contributors
---
* [Tatsuo Kaniwa](https://github.com/t-k) - Creator of the project

Copyright
---
