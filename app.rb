require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark.rb'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb(:index)
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb(:'bookmarks/index')
  end

  get '/bookmarks/new' do
    erb(:'bookmarks/new')
  end

  post '/bookmarks' do
    url = params[:bookmark_url]
    name = params[:bookmark_name]
    flash[:invalid_url] = "Invalid URL" unless Bookmark.create(url, name)
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
