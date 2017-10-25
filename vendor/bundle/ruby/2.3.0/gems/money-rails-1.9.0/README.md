# RubyMoney - Money-Rails

[![Gem Version](https://badge.fury.io/rb/money-rails.svg)](http://badge.fury.io/rb/money-rails)
[![Build Status](https://secure.travis-ci.org/RubyMoney/money-rails.svg?branch=master)](http://travis-ci.org/RubyMoney/money-rails)
[![Dependency Status](https://gemnasium.com/RubyMoney/money-rails.svg)](https://gemnasium.com/RubyMoney/money-rails)
[![Code Climate](https://codeclimate.com/github/RubyMoney/money-rails.svg)](https://codeclimate.com/github/RubyMoney/money-rails)
[![License](http://img.shields.io/:license-mit-green.svg?style=flat)](http://opensource.org/licenses/MIT)

## Introduction

This library provides integration of the [money](http://github.com/Rubymoney/money) gem with Rails.

Use 'monetize' to specify which fields you want to be backed by
Money objects and helpers provided by the [money](http://github.com/Rubymoney/money)
gem.

Currently, this library is in active development mode, so if you would
like to have a new feature, feel free to open a new issue
[here](https://github.com/RubyMoney/money-rails/issues). You are also
welcome to contribute to the project.

## Installation

Add this line to your application's Gemfile:

    gem 'money-rails', '~>1'

And then execute:

    $ bundle

Or install it yourself using:

    $ gem install money-rails

You can also use the money configuration initializer:

```
$ rails g money_rails:initializer
```

There, you can define the default currency value and set other
configuration parameters for the rails app.

Without Rails in rack-based applications, call during initialization:

```ruby
MoneyRails::Hooks.init
```

## Usage

### ActiveRecord

#### Usage example

For example, we create a Product model which has an integer column called
`price_cents` and we want to handle it using a `Money` object instead:

```ruby
class Product < ActiveRecord::Base

  monetize :price_cents

end
```

Now each Product object will also have an attribute called ```price``` which
is a `Money` object, and can be used for money comparisons, conversions etc.

In this case the name of the money attribute is created automagically by removing the
```_cents``` suffix from the column name.

If you are using another db column name, or you prefer another name for the
money attribute, then you can provide an ```as``` argument with a string
value to the ```monetize``` macro:

```ruby
monetize :discount_subunit, :as => "discount"
```

Now the model objects will have a ```discount``` attribute which is a `Money`
object, wrapping the value of the ```discount_subunit``` column with a Money
instance.

#### Migration helpers

If you want to add a money field to a product model you can use the ```add_money``` helper. This
helper can be customized inside a ```MoneyRails.configure``` block. You should customize the
```add_money``` helper to match the most common use case and utilize it across all migrations.

```ruby
class MonetizeProduct < ActiveRecord::Migration
  def change
    add_money :products, :price    # Rails 3
    add_monetize :products, :price # Rails 4x and above

    # OR

    change_table :products do |t|
      t.money :price    # Rails 3
      t.monetize :price # Rails 4x and above
    end
  end
end
```

Another example, where the currency column is not included:

```ruby
class MonetizeItem < ActiveRecord::Migration
  def change
    add_money :items, :price, currency: { present: false }
  end
end
```

Notice. Default value of currency field, generated by migration's helper, is USD. To override these defaults, you need change default_currency in money initializer and run migrations.

The ```add_money``` helper is reversible, so you an use it inside ```change```
migrations.  If you're writing separate ```up``` and ```down``` methods, you
can use the ```remove_money``` helper.

##### Notice for Rails >= 4.2 and PG adapter

Due to the addition of the `money` column type for PostgreSQL in Rails 4.2, you
will need to use `add_monetize` instead of `add_money` column. If you're adding
the column within a `create_table` block, use `t.monetize`, and use
`remove_monetize` to remove the column.

#### Allow nil values

If you want to allow nil and/or blank values to a specific
monetized field, you can use the `:allow_nil` parameter:

```ruby
# in Product model
monetize :optional_price_cents, :allow_nil => true

# in Migration
def change
  add_money :products, :optional_price, amount: { null: true, default: nil }
end

# now blank assignments are permitted
product.optional_price = nil
product.save # returns without errors
product.optional_price # => nil
product.optional_price_cents # => nil
```

#### Allow large numbers

If you foresee that you will be saving large values (range is -2147483648 to +2147483647 for Postgres), increase your integer column limit to bigint:

```ruby
def change
  change_column :products, :price_cents, :integer, limit: 8
end
```

#### Numericality validation options

You can also pass along
[numericality validation options](http://guides.rubyonrails.org/active_record_validations.html#numericality)
such as this:

```ruby
monetize :price_in_a_range_cents, :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 10000
  }
```

Or, if you prefer, you can skip validations entirely for the attribute. This is useful if chosen attributes
are aggregate methods and you wish to avoid executing them on every record save.

```ruby
monetize :price_in_a_range_cents, :disable_validation => true
```

You can also skip validations independently from each other by simply passing `false`
to the validation you are willing to skip, like this:

```ruby
monetize :price_in_a_range_cents, :numericality => false
```

### Mongoid 2.x and 3.x

`Money` is available as a field type to supply during a field definition:

```ruby
class Product
  include Mongoid::Document

  field :price, type: Money
end

obj = Product.new
# => #<Product _id: 4fe865699671383656000001, _type: nil, price: nil>

obj.price
# => nil

obj.price = Money.new(100, 'EUR')
# => #<Money cents:100 currency:EUR>

obj.price
#=> #<Money cents:100 currency:EUR>

obj.save
# => true

obj
# => #<Product _id: 4fe865699671383656000001, _type: nil, price: {:cents=>100, :currency_iso=>"EUR"}>

obj.price
#=> #<Money cents:100 currency:EUR>

## You can access the money hash too:
obj[:price]
# => {:cents=>100, :currency_iso=>"EUR"}
```

The usual options on `field` as `index`, `default`, ..., are available.

### Method conversion

Method return values can be monetized in the same way attributes are monetized. For example:

```ruby
class Transaction < ActiveRecord::Base

  monetize :price_cents
  monetize :tax_cents
  monetize :total_cents
  def total_cents
    return price_cents + tax_cents
  end

end
```

Now each Transaction object has a method called `total` which returns a `Money` object.

### Currencies

money-rails supports a set of options to handle currencies for your
monetized fields. The default option for every conversion is to use
the global default currency of the Money library, as given in the configuration
initializer of money-rails:

```ruby
# config/initializers/money.rb
MoneyRails.configure do |config|

  # set the default currency
  config.default_currency = :usd

end
```

If you need to set the default currency on a per-request basis, such as in a
multi-tenant application, you may use a lambda to lazy-load the default currency
from a field in a configuration model called `Tenant` in this example:

```ruby
# config/initializers/money.rb
MoneyRails.configure do |config|

  # set the default currency based on client configuration
  config.default_currency = -> { Tenant.current.default_currency }
end
```

In many cases this is not enough, so there are some other options to
meet your needs.

#### Model Currency

You can override the global default currency within a specific ActiveRecord
model using the ```register_currency``` macro:

```ruby
# app/models/product.rb
class Product < ActiveRecord::Base

  # Use EUR as model level currency
  register_currency :eur

  monetize :discount_subunit, :as => "discount"
  monetize :bonus_cents

end
```

Now ```product.discount``` and ```product.bonus``` will return a `Money`
object using EUR as their currency, instead of the default USD.

(This is not available in  Mongoid).

#### Attribute Currency (:with_currency)

By passing the option ```:with_currency``` to the ```monetize``` macro call,
with a currency code as its value, you can define a currency in a more granular
way. This will you attach the given currency only to the specified monetized model
attribute (allowing you to, for example, monetize different attributes of the same model with different currencies.).

This allows you to override both the model level and the global
default currencies:

```ruby
# app/models/product.rb
class Product < ActiveRecord::Base

  # Use EUR as the model level currency
  register_currency :eur

  monetize :discount_subunit, :as => "discount"
  monetize :bonus_cents, :with_currency => :gbp

end
```

In this case ```product.bonus``` will return a Money object with GBP as its
currency, whereas ```product.discount.currency_as_string # => EUR ```

#### Instance Currencies

All the previous options do not require any extra model fields to hold
the currency values. If the currency of a field will vary from
one model instance to another, then you should add a column called ```currency```
to your database table and pass the option ```with_model_currency```
to the ```monetize``` macro.

money-rails will use this knowledge to override the model level and global
default values. Non-nil instance currency values also override attribute
currency values, so they have the highest precedence.

```ruby
class Transaction < ActiveRecord::Base

  # This model has a separate currency column
  attr_accessible :amount_cents, :currency, :tax_cents

  # Use model level currency
  register_currency :gbp

  monetize :amount_cents, with_model_currency: :currency
  monetize :tax_cents, with_model_currency: :currency

end

# Now instantiating with a specific currency overrides
# the model and global currencies
t = Transaction.new(:amount_cents => 2500, :currency => "CAD")
t.amount == Money.new(2500, "CAD") # true
```

### Configuration parameters

You can handle a bunch of configuration params through ```money.rb``` initializer:

```ruby
MoneyRails.configure do |config|

  # To set the default currency
  #
  # config.default_currency = :usd

  # Set default bank object
  #
  # Example:
  # config.default_bank = EuCentralBank.new

  # Add exchange rates to current money bank object.
  # (The conversion rate refers to one direction only)
  #
  # Example:
  # config.add_rate "USD", "CAD", 1.24515
  # config.add_rate "CAD", "USD", 0.803115

  # To handle the inclusion of validations for monetized fields
  # The default value is true
  #
  # config.include_validations = true

  # Default ActiveRecord migration configuration values for columns:
  #
  # config.amount_column = { prefix: '',           # column name prefix
  #                          postfix: '_cents',    # column name  postfix
  #                          column_name: nil,     # full column name (overrides prefix, postfix and accessor name)
  #                          type: :integer,       # column type
  #                          present: true,        # column will be created
  #                          null: false,          # other options will be treated as column options
  #                          default: 0
  #                        }
  #
  # config.currency_column = { prefix: '',
  #                            postfix: '_currency',
  #                            column_name: nil,
  #                            type: :string,
  #                            present: true,
  #                            null: false,
  #                            default: 'USD'
  #                          }

  # Register a custom currency
  #
  # Example:
  # config.register_currency = {
  #   :priority            => 1,
  #   :iso_code            => "EU4",
  #   :name                => "Euro with subunit of 4 digits",
  #   :symbol              => "€",
  #   :symbol_first        => true,
  #   :subunit             => "Subcent",
  #   :subunit_to_unit     => 10000,
  #   :thousands_separator => ".",
  #   :decimal_mark        => ","
  # }

  # Specify a rounding mode
  # Any one of:
  #
  # BigDecimal::ROUND_UP,
  # BigDecimal::ROUND_DOWN,
  # BigDecimal::ROUND_HALF_UP,
  # BigDecimal::ROUND_HALF_DOWN,
  # BigDecimal::ROUND_HALF_EVEN,
  # BigDecimal::ROUND_CEILING,
  # BigDecimal::ROUND_FLOOR
  #
  # set to BigDecimal::ROUND_HALF_EVEN by default
  #
  # config.rounding_mode = BigDecimal::ROUND_HALF_UP

  # Set default money format globally.
  # Default value is nil meaning "ignore this option".
  # Example:
  #
  # config.default_format = {
  #   :no_cents_if_whole => nil,
  #   :symbol => nil,
  #   :sign_before_symbol => nil
  # }
end
```

* ```default_currency```: Set the default (application wide) currency (USD is the default)
* ```include_validations```: Permit the inclusion of a ```validates_numericality_of```
  validation for each monetized field (the default is true)
* ```register_currency```: Register one custom currency. This option can be
  used more than once to set more custom currencies. The value should be
  a hash of all the necessary key/value pairs (important keys: ```:priority```, ```:iso_code```,
  ```:name```, ```:symbol```, ```:symbol_first```, ```:subunit```, ```:subunit_to_unit```,
  ```:thousands_separator```, ```:decimal_mark```).
* ```add_rate```: Provide custom exchange rate for currencies in one direction
  only! This rate is added to the attached bank object.
* ```default_bank```: The default bank object holding exchange rates etc.
  (https://github.com/RubyMoney/money#currency-exchange)
* ```default_format```: Force `Money#format` to use these options for formatting.
* ```amount_column```: Provide values for the amount column (holding the fractional part of a money object).
* ```currency_column```: Provide default values or even disable (`present: false`) the currency column.
* ```rounding_mode```: Set Money.rounding_mode to one of the BigDecimal constants

### Helpers

_For examples below, `@money_object == <Money fractional:650 currency:USD>`_

| Helper                                                | Result                                    |
|:---	                                                |:---	                                    |
| `currency_symbol`  	                                | `<span class="currency_symbol">$</span>`  |
| `humanized_money @money_object`  	                    | 6.50                                      |
| `humanized_money_with_symbol @money_object`           | $6.50                                     |
| `money_without_cents @money_object`                   | 6                                         |
| `money_without_cents_and_with_symbol @money_object`   | $6                                        |

#### `no_cents_if_whole`

`humanized_money` and `humanized_money_with_symbol` will not render the cents part if it contains only zeros, unless `config.no_cents_if_whole` is set to `false` in the `money.rb` configuration (default: true).
Note that the `config.default_format` will be overwritten by `config.no_cents_if_whole`.
So `humanized_money` will ignore `config.default_format = { no_cents_if_whole: false }` if you don't set `config.no_cents_if_whole = false`.

### Testing

If you use Rspec there is a test helper implementation.
Just write `require "money-rails/test_helpers"` in spec_helper.rb.

* the `monetize` matcher

```ruby
is_expected.to monetize(:price)
```
This will ensure that a column called `price_cents` is being monetized.

```ruby
is_expected.to monetize(:price).allow_nil
```
By using `allow_nil` you can specify money attributes that accept nil values.

```ruby
is_expected.to monetize(:price).as(:discount_value)
```
By using `as` chain you can specify the exact name to which a monetized
column is being mapped.

```ruby
is_expected.to monetize(:price).with_currency(:gbp)
```

By using the `with_currency` chain you can specify the expected currency
for the chosen money attribute. (You can also combine all the chains.)

For examples on using the test_helpers look at
[test_helpers_spec.rb](https://github.com/RubyMoney/money-rails/blob/master/spec/test_helpers_spec.rb)

## Supported ORMs/ODMs

* ActiveRecord (>= 3.x)
* Mongoid (2.x, 3.x)

## Supported Ruby interpreters

* MRI Ruby >= 1.9.2

You can see a full list of the currently supported interpreters in [travis.yml](http://github.com/RubyMoney/money-rails/blob/master/.travis.yml)

## Contributing

### Steps

1. Fork the repo
2. Run the tests
3. Make your changes
4. Test your changes
5. Create a Pull Request

### How to run the tests

Our tests are executed with several ORMs - see `Rakefile` for details. To install all required gems run `rake spec:all` That command will take care of installing all required gems for all the different Gemfiles and then running the test suite with the installed bundle.

You can also run the test suite against a specific ORM or Rails version, `rake -T` will give you an idea of the possible task (take a look at the tasks under the spec: namespace).

If you are testing against mongoid, make sure to have the mongod process running before executing the suite,  (E.g. `sudo mongod --quiet`)

## Maintainers

* Andreas Loupasakis (https://github.com/alup)
* Shane Emmons (https://github.com/semmons99)
* Simone Carletti (https://github.com/weppos)

## License

MIT License. Copyright 2012-2014 RubyMoney.