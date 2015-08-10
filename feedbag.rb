require "feedbag"
require "sinatra"
require "sinatra/json"
require "sinatra/reloader" if development?
require "haml"

configure do
  enable :inline_templates
end

get "/" do
  @url = params[:url].to_s
  unless @url.empty?
    @feeds = Feedbag.find(@url)
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
  Returns a list of feed URLs using
  = succeed "." do
    %a{ href: "https://github.com/damog/feedbag" } Feedbag

%p
  Example:
  %a{ href: url }= url

- unless @url.empty?
  %h2= "Feeds for #{@url}"

  %ul
    - @feeds.each do |feed|
      %li
        %a{ href: feed }= feed

  %p Explore the feeds with Feedjira:

  %h3 Pretty XML with syntax highlighting
  %ul
    - @feeds.each do |feed|
      - xmlurl = "https://feedjira.herokuapp.com/xml?url=#{feed}"
      %li
        %a{ href: xmlurl }= xmlurl
  %h3 JSON
  %ul
    - @feeds.each do |feed|
      - url = "https://feedjira.herokuapp.com/?url=#{feed}"
      %li
        %a{ href: url }= url

  - if @feeds.empty?
    %p No feeds found.
