require 'sidekiq/web'
require 'sinatra/base'
require 'redis'

class App < Sinatra::Base
  template :index do
    <<'EOS'
<ul>
<% @articles.each.with_index do |article, idx| %>
<li>
<% if article['body'] == "E" %>
<font color="red"><%= article['title'] %></font> - <a href="<%= article['imageURL'] %>"><%= article['imageURL'] %></a>
<% else %>
<%= article['title'] %> - <a href="<%= article['imageURL'] %>"><%= article['imageURL'] %></a>
<% end %>
</li>
<% end %>
</ul>
EOS
  end

  get '/' do
    redis = Redis.new
    keys = redis.keys('articles/*')
    return 'no content' if keys == nil || keys.empty?
    @articles = redis.mget(*keys).map { |x| JSON.parse(x) }
    erb :index
  end
end

run Rack::URLMap.new(
      '/' => App,
      '/sidekiq' => Sidekiq::Web
    )
