require 'pry'
require 'watir'

Before do |scenario|
  @browser = Watir::Browser.new(
      :phantomjs,
      :args => ["--ssl-protocol=tlsv1","--ignore-ssl-errors=true"],
    )
end

After do |scenario|
end
