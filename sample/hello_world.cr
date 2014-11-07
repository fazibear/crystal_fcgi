require "html/builder"
require "../src/fcgi"

def response
  "Content-type: text/html\r\n\r\n" + HTML::Builder.new.build do
    html do
      head do
        title { text "Crystal Programming Language" }
      end
      body do
        h1 { text "Hello #{rand(500)}" }
        a({href: "http://crystal-lang.org"}) { text "Crystal rocks!" }
      end
    end
  end
end

request = FCGX::Request.new

FCGX.init
FCGX.init_request(pointerof(request) , 0, 0)

while FCGX.accept_r(pointerof(request)) == 0
  FCGX.put_s(response, request.out)
end
