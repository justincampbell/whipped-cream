# whipped-cream

## DSL

```rb
name "Garage"

camera

button "Open/Close", pin: 1 do
  tap
end

sensor "Status", pin: 2 do
  if value == :high
    "Opened"
  else
    "Closed"
  end
end

sensor "Temperature", pin: 3, unit: "F" do
  binary_to_farenheit(value)
end

helpers do
  def binary_to_farenheit(binary)
    binary.to_f * 123.45
  end
end
```
