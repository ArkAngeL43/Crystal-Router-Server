require "./src/Server"

puts "Application running"

application = Server::Base.new
application.process "/" do
    ""
end
application.process "/example" do  ""
end


application.run(8080, "example.html")
