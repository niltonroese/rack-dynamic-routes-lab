class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last 
            check_item_price(item_name, resp)
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish

    end

    def check_item_price(item, resp)
        if found = @@items.find{|i| i.name == item}
            resp.write found.price
        else
            resp.write "Item not found"
            resp.status = 400
        end
    end

end