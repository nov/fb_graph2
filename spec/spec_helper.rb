require 'simplecov'

SimpleCov.start do
  add_filter 'spec'
end

require 'rspec'
require 'fb_graph2'

Dir[File.join(__dir__, 'spec_helper/*.rb')].each do |file|
  require file
end