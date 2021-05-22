#1. 

  rails new name-of-app --database=postgresql

#2. 
  
  create model then cotroller then views

#3. 

  rails generate model Song title year:integer

#4. 
  
  rails db:migrate

#5.
  
  model file and migration file

#6. 

  rails generate migration AddCategoryToSong 
  
  #in migration file: 
    add_column :table_name_plural, :column_name, :data_type

#7. migration file and model file

#8. 

  rails db:migrate

#9. 

  validates :title, presence: true

#10. 

rails c  #create a song without a title and check if it has been saved

#11. 3 1 2 4

#12. verb, url, body, headers

#13. No. One is get the other is post and they are pointing to two different controller actions

#14. get passes data trough the url and post trough the body

#15.

  Song.find_by(category: params[:query])

#16. 

  Song.find_by(title: params[:name])

	Song.where(title: params[:name]) #use this for getting an array of model instances instead of just one 


#17. 

  resources :songs #to create them

  # get '/songs/new, to: 'songs#new'
  # post '/songs', to: 'songs#create'
  # get '/songs/:id', to: 'songs#show'
  # get '/songs', to: 'songs#index'
  # get '/songs/:id/edit', to: 'songs#edit'
  # put '/songs/:id', to: 'songs#update'
  # delete '/songs/:id', to: 'songs#destroy'

#18. 

  rails routes

#19. In terminal:
  
  #rails generate controller Songs  

  #or to create it with pre-existing routes and views: 

  #rails generate controller Songs index show new

#20. 

  def index
  	@songs = Song.all
  end

  def show
  	@song = Song.find(params[:id])
  end

# 21. ===================================
  class SongsController < ApplicationController

    def index
    	@songs = Song.all
    end

    def show
    	@song = Song.find(params[:id])
    end

    def new
    	@song = Song.new
    end

    def create
    	@song = Song.new(song_params)
    	
    	if @song.save
    		redirect_to songs_path
    	else
    		render[:new]
    	end
    end

    private

    def song_params
    
    	params.require(:song).permit(:title, :year, :category)
    end
  end  

#======================================
 
#22. To prevent people hacking our app and taking over controll by giving themselves access by passing params like admin: true   

#23. 
  # <form action="/songs" method="post">
	#   <input type="text" name="title" value="Title">
	#   <input type="submit" value="Create song">
	# </form>

#24. 

  # <form action="/songs/18" method="patch">
  #   <input type="text" name="song[title]" value="Hey jude"/>
  #   <input type="submit" value="Update song"/>
  # </form>

#25. rails generate model review content:string song:references in terminal

#26. rails db:migrate

#27.

  class Song < ApplicationRecord
    has_many :reviews, dependent: :destroy # or dependent: :nullify
  end

  class Review < ApplicationRecord
    belongs_to :song
    validates :content, presence: true
  end

#28. rails generate controller reviews in terminal

#29. 
  resources :songs do
    resources :reviews, only: [:new, :create]
  end

#30. 
  
class ReviewsController < ApplicationController
  before_action :set_song
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.song = @song
    if @review.save
      redirect_to song_path(@song)
    else
      render :new
    end
  end

  private

  def set_song
    @song = Song.find(params[:song_id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end

#31.

  # <h1><%= @song.title %></h1>
  # <p><%= @song.year %></p>
  # <p><%= @song.category %></p>

  # <h2>Here are the reviews for this song:</h2>
  # <ul>
  # <% @song.reviews.each do |review| %>
  #   <li><%= review.content %></li>
  # <% end %>
  # </ul>
