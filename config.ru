require 'sidekiq/web'
require 'sinatra/base'
require 'redis'

class App < Sinatra::Base
  template :index do
    <<'EOS'
<% @articles.each.with_index do |article, idx| %>
<% if idx % 5 == 0 %>
<br />
<% end %>
<img width="400" src="<%= article['imageURL'] %>" />
<% end %>
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
