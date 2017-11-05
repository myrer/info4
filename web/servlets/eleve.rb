class EleveServlet < WEBrick::HTTPServlet::AbstractServlet
	def do_GET request, response
		
		action = request.path.split("/")[2]
		body =  "Query hash : #{request.query}\n"
		body <<  "Path : #{request.path}\n"
		body <<  "action : #{action}\n"
		
		case 
		when action == 'former'
			former_groupes
		else
			body << "\t#{request.query}"
		end	
		
		response.status = 200
		response['Content-Type'] = 'text/plain'
		response.body =  body
	
	end
end