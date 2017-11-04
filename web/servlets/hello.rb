class Hello < WEBrick::HTTPServlet::AbstractServlet
  def do_GET request, response
    #status, content_type, body = do_stuff_with request
	
    response.status = 200
    response['Content-Type'] = 'text/plain'
    body =  "Query hash : #{request.query}\n"
	body << "Hello #{request.query['name']}!"
	
    response.body =  body
	
  end
end