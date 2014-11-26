require "feedbag"
require "sinatra"
require "sinatra/json"
require "sinatra/reloader" if development?
require "haml"

configure do
  enable :inline_templates
end

get "/" do
  unless params[:url].to_s.empty?
    @feeds = Feedbag.find(params[:url])
  else
    @feeds = []
  end
  haml :index
end

__END__

@@ layout
%html
  %head
    %title Feedbag
  %body
    = yield

@@ index

- port = [80, 443].include?(request.port) ? "" : ":#{request.port}"
- url = "#{request.scheme}://#{request.host}#{port}/?url=blog.trello.com"
%p
  Returns a list of feed URLs.
  %a{ href: url }= url

%ul
  - @feeds.each do |feed|
    - url = "https://feedjira.herokuapp.com/?url=#{feed}"
    %li
      %a{ href: url }= url

%p
  Using
  = succeed "." do
    %a{ href: "https://github.com/damog/feedbag" } Feedbag
