# D12n

D12n (=delocalization) can be used to cast model attributes from localized format BigDecimal. This is done by adding an
additional attribute to the model which keeps the original value the user is entering. This has the advantage that the
original user input can be validated and rendered back to the user during validation errors.

## Usage

```ruby
gem 'd12n'
