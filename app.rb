require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark.rb'

class BookmarkManager < Sinatra::Base
# method_overide allows me to use delete and patch paths
  enable :sessions, :method_override
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

  delete '/bookmarks/:id/delete' do
    id = params[:id]
    Bookmark.delete(id)
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/edit' do
    @id = params[:id]
    erb(:'bookmarks/edit')
  end

  # patch '/bookmarks/:id/edit' do
  #   id = params[:id]
  #   Bookmark.edit(id)
  #   redirect('/bookmarks')
  # end

  post '/bookmarks' do
    url = params[:bookmark_url]
    name = params[:bookmark_name]
    flash[:invalid_url] = "Invalid URL" unless Bookmark.create(url, name)
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
