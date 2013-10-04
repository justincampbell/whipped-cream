name "Demo"

button "Open/Close", pin: 1

sensor "Door", pin: 2, high: "Open", low: "Closed"

sensor "Ruby Version" do
  RUBY_VERSION
end
