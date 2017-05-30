Dir[File.join(__dir__, 'open_graph/*.rb')].each do |file|
  require file
end