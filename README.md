# D12n

D12n (=delocalization) can be used to cast model attributes from localized format to an internal BigDecimal or Integer
representation. This is done by adding an additional attribute to the model which keeps the original value the user has
entered. This has the advantage that the original user input can be validated and rendered back to the user during
validation errors.

## Usage

```ruby
gem 'd12n'
```

Sample model

```ruby
class Dummy
  include D12n::ModelSupport

  attr_accessor :amount
  d12n_attribute :amount
end
```

```ruby
d = Dummy.new

d.amount = 1_234.56
d.local_amount # "1,234.56"

d.local_amount = '3,456.78'
d.amount.class # BigDecimal
d.amount.to_f # 3456.78

d.local_amount = 'invalid'
d.amount.to_f # 3456.78, did not change
```

## Configuration

```ruby
# the default, no need to set it
# It will use the settings from your I18n locale (number.format) to parse and generate the formatted number
# It is heavily recommended to use this
D12n.config.strategy = D12n::Strategy::Default

# Hard coded strategy using decimal point
D12n.config.strategy = D12n::Strategy::DecimalPoint

# Hard coded strategy using decimal comma
D12n.config.strategy = D12n::Strategy::DecimalComma
```

### Custom method prefix

```ruby
d12n_attribute :amount, prefix: 'localized'
```

Would give you `localized_amount` instead of `local_amount`.

### Internal integer representation with a factor

If your internal representation is for example in cents, but the local format should be EUR with decimal point
you can use this option:

```ruby
d12n_attribute :amount, factor: 100
```

```ruby
d = Dummy.new

d.amount = 1_234
d.local_amount # "12,34"

d.local_amount = '3,456.78'
d.amount.class # Integer
d.amount # 345_678
```
