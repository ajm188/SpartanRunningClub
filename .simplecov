SimpleCov.start do
  add_filter do |src|
    src.filename.start_with? "#{SimpleCov.root}/config" unless
      src.filename.end_with? 'routes.rb'
  end
  add_filter '/spec'
  add_filter '/app/helpers'
  add_filter '/app/mailers'
  add_filter '/features'
end
