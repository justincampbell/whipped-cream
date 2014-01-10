name "Demo"

button "Open/Close", pin: 4

sensor "Door", pin: 17, high: "Open", low: "Closed"

switch "Light", pin: 18

sensor "Ruby Version" do
  RUBY_VERSION
end
