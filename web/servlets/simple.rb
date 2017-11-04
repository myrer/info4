#~ require 'erb'
class Simple < WEBrick::HTTPServlet::AbstractServlet
	def do_GET request, response
		response.status = 200
		response['Content-Type'] = 'text/html'
		template = read_template("index")
		e = ERB.new(template)
		
		response.body = e.result(binding)
	end

private
	def read_template(file_name)
		template = ""
		f = File.open("./html/#{file_name}.rhtml", "r")
		while line = f.gets
			template << line
		end	
		f.close
		return template
	end	
end