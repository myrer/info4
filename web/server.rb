require 'erb'
require 'webrick'

servlet_path = "./servlets"
servlet_names = %w[ Bonjour Hello Simple]

servlet_names.each {|name| require_relative("#{servlet_path}/#{name.downcase}.rb")}


defined_servlets = ObjectSpace.each_object.select{|object| servlet_names.include?(object.to_s)}.reject{|x| x.class == String}

#-----
server = WEBrick::HTTPServer.new({ :Port => 8000, :DocumentRoot => "./views"})
# Add a mime type for *.rhtml files
WEBrick::HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html')

trap 'INT' do server.shutdown end
#-----

defined_servlets.each {|servlet| server.mount "/#{servlet.to_s.downcase}", servlet }

server.mount("/fs", WEBrick::HTTPServlet::FileHandler, "/home/rick/rbf/info4/web/views")

server.start