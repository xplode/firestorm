require 'selenium-webdriver'

url = ARGV[0]
iterations = ARGV[1] ? ARGV[1].to_i :  1

def setup
  puts "Setting up selenium webdriver for firefox."
  @driver = Selenium::WebDriver.for :firefox
  puts @driver.methods.to_s
end

def teardown
  puts "Tearing down selenium webdriver."
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  puts "Fetching #{url}"
  @driver.get url
  (0..iterations).each do
    puts "Refreshing #{url}"
    @driver.navigate.refresh
  end
  puts "Done."
end

