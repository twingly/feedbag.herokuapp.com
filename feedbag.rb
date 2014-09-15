require "feedbag"
require "sinatra"
require "sinatra/json"
require "sinatra/reloader" if development?
require "haml"

set :protection, :except => [:json_csrf]

configure do
  enable :inline_templates
end

get "/" do
  unless params[:url].to_s.empty?
    json Feedbag.find(params[:url])
  else
    haml :index
  end
end

__END__

@@ layout
%html
  %head
    %title Feedbag
  %body
    = yield

@@ index
- url = "#{request.url}?url=blog.trello.com"
%p
  Returns a JSON array with feed URLs:
  %a{ href: url }= url

%p
  Using
  = succeed "." do
    %a{ href: "https://github.com/damog/feedbag" } Feedbag
