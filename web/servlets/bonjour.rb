class Bonjour < WEBrick::HTTPServlet::AbstractServlet
  def do_GET request, response
    #status, content_type, body = do_stuff_with request

    response.status = 200
    response['Content-Type'] = 'text/plain'
    response.body = 'Bonjour tout le monde!'
  end
end