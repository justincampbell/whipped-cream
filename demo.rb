name "Demo"

camera

button "Open/Close", pin: 1

sensor "Door", pin: 2, high: "Open", low: "Closed"

switch "Light", pin: 3

sensor "Ruby Version" do
  RUBY_VERSION
end
