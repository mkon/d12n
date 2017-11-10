# D12n

D12n (=delocalization) can be used to cast model attributes from localized format BigDecimal. This is done by adding an
additional attribute to the model which keeps the original value the user is entering. This has the advantage that the
original user input can be validated and rendered back to the user during validation errors.

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
D12n.config.strategy = D12n::Strategy::DecimalPoint # the default
D12n.config.strategy = D12n::Strategy::DecimalComma
```

### Custom method prefix

```ruby
d12n_attribute :amount, prefix: 'localized'
```

Would give you `localized_amount` instead of `local_amount`.
