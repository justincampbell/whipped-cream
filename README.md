# whipped-cream

## DSL

```rb
name "Garage"

camera

button "Open/Close", pin: 1 do
  tap
end

sensor "Door",
  pin: 2,
  low: "Closed",
  high: "Open",
  on_high: :door_opened

sensor "Temperature", pin: 3, unit: "F" do
  binary_to_farenheit(value)
end

helpers do
  def binary_to_farenheit(binary)
    binary.to_f * 123.45
  end

  def door_opened
    WhippedCream.find("Front Door").ring_bell
  end
end
```
