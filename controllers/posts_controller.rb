class PostsController < Sinatra::Base #Base is a mini class. In this case, it allows us to use the HTTP verbs because that is in the base of Sinatra.

  configure :development do
    register Sinatra::Reloader
  end

  # Set root as the parent directory of the current file
  set :root, File.join(File.dirname(__FILE__),  "..")

  # Sets the view directory correctly
  set :views, Proc.new {File.join(root, "views")}

  $posts = [     #global variable. Can be used anywhere in the ...
    {
      :id => 0,
      :title => "Post 1",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 1,
      :title => "Post 2",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 2,
      :title => "Post 3",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
  ]

  #Index

  get "/" do

    @title = "Posts Index"
    @posts = $posts # Bringing in our global variable as a local variable
    erb :"posts/index"
  end

  #New
  get "/new" do
    @post = {
      :id => "",
      :title => "",
      :body => ""
    }
    erb :"posts/new"
  end

  get "/:id" do
    id = params[:id].to_i
    @title = "Show Post"
    @post = $posts[id]

    erb :"posts/show"
  end

  #Create
  post "/" do

    id = $posts.last[:id] + 1

    new_post = {
      :id => id,
      :title => params[:title],
      :description => params[:description]
    }
    $posts.push new_post

    redirect "/" #This is a get request
  end

  #Edit
  get "/:id/edit" do
    id = params[:id].to_i
    "Edit page for #{ :id }"
    @post = $posts[id]
    erb :"posts/edit"
  end

  #Update
  put '/:id' do
    # Get id from params
    id = params[:id].to_i

    # Get hash from array
    post = $posts[id]

    # Update the necessary has with the values from the params
    post[:title] = params[:title]
    post[:body] = params[:body]

    # Save the new data back into our array
    $posts[id] = post

    redirect "/"
  end

  #Destroy
  delete "/:id" do
    id = params[:id].to_i
    $posts.delete_at id

    redirect '/'
  end

end
