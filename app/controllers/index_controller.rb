#    ------------** Numerology App using Sinatra **-------------------     #
require 'sinatra'
set :bind, '0.0.0.0'


get '/:birthdate' do
    setup_index_view
end

# Use this code to allow birthdate to be selected from a date picker
get '/message/:birth_path_number' do
    birth_path_number = params[:birth_path_number].to_i
    @message = Person.statement(birth_path_number)
    erb :index
end

# Creates a get ‘/’ route that gets the form.erb
get '/' do
    erb :form
end

# Creates a post '/' route to input data into the form 
post '/' do
    birthdate = params[:birthdate].gsub("-","")
    if Person.valid_birthdate(birthdate)
        birth_path_number = Person.path_number(birthdate)
        redirect "/message/#{birth_path_number}"
        # if redirect was not used would simply put: setup_index_view
    else
        erb :form
end 
@error = "You should enter a valid birthdate in the form of mmddyyyy." 
end

def setup_index_view
    birthdate = params[:birthdate]
    # Assigns birth path number to a variable 
    birth_path_number = Person.path_number(birthdate)
    # Assigns the correct message to a variable
    @message = Person.statement(birth_path_number)
    erb :index
end