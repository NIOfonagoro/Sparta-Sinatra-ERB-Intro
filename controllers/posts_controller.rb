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
      :id => 0
      :title => "Post 1"
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 1
      :title => "Post 2"
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 2
      :title => "Post 3"
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
  ]

  get "/" do

    @title = "Posts Index"
    erb :"posts/index"
  end

end
