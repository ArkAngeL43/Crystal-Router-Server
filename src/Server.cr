require "http/server"
require "./Responder.cr"





module Server 
    class Base 
        def initialize
            @router = {

            } of String => ( -> String )
        end

        def run(int port, string filename)
            server = HTTP::Server.new do |ctx|
                ctx.response.content_type = "multipart/form-data"
                ctx.response.content_type = "boundary=aA40"
                req = ctx.request
                if @router.has_key?(req.path.to_s)
                    if req.method == "GET"
                        aoo = Responder::Switcher.new 
                        fo = aoo.return_base_path(req.path.to_s)
                        ctx.response.content_length = File.size(fo.to_s)
                        File.open(fo.to_s) do |f|
                            IO.copy(f, ctx.response)
                        end
                    end 
                    if req.method == "POST"
                            HTTP::FormData.parse(ctx.request) do |part|
                                case part.name
                                when "fname"
                                    puts part.body.gets_to_end
                                end
                            end
                    end
                else 
                    ctx.response.respond_with_status(401, " Not found please return to the root path / #{req.method}")
                end
            end
            server.listen(port)
        end
        def process(router, &block : (-> String))
            @router[router.to_s] = block
        end
    end
end
