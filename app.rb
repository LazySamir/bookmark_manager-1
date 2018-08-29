require 'sinatra/base'
require './lib/bookmark.rb'

class BookmarkManager < Sinatra::Base

  enable :sessions


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
    Bookmark.create(params[:bookmark_url])
    redirect '/bookmarks'  
  end

  run! if app_file == $0

end
