class Application

  @@cart = []
  @@items = ["Apples","Carrots","Pears"]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      if @@cart == []
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
         resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/)
      add_item = req.params["item"]
      resp.write handle_search(add_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(item)
    if @@items.include?(item)
      @@cart << item 
      return "added #{item}"
    else
      return "We don't have that item"
    end
  end
end
