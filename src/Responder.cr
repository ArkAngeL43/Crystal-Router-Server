require "./Template.cr"

filename = "example.html"

module Responder 
    class Switcher
        def return_base_path(path_of_file : String)
            server_Locations = {
                "/example" => "HTML/example.html",
                "/"        => "HTML/main.html",
            }
            if path_of_file == "/"
                if File.exists?(server_Locations[path_of_file]) 
                    tem = Loader::Template.new
                    tem.fill_simple_Template("Hey there, welcome to the pre generated file")
                    puts "Template finished....[main.html]"
                end
            end
            server_Locations[path_of_file]
        end
    end
end