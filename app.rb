 require "sinatra"
 require "instagram"
 

 enable :sessions
 
 cb_url= "http://localhost:9393/oauth/callback"

 Instagram.configure do |config|
	config.client_id="03bc85df0afd49b7bc63f6ed9dd69ab5"
	config.client_secret="b7cb00031a8143fcb5d3996946ea8802"
 end


 get '/' do
 
 erb :index
 end

 get '/oauth/connect' do 
   
  redirect Instagram.authorize_url(:redirect_uri => cb_url)
 end

 get '/oauth/callback' do
    reponse=Instagram.get_access_token(params[:code],:redirect_url => cb_url)
    session[:acess_token]=response.access_token 
    redirect '/feed'
 end

 get '/feed' do
   @app=Instagram.client(:acess_token => session[:acess_token])
   @user=@app.user
   @valentine_day=@app.tag('valentinesday')
  erb :feed

 end
 
 


