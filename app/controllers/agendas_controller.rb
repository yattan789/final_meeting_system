class AgendasController < ApplicationController
  before_action :authenticate_user!
  before_action :check


    
  def check
    if current_user.status == true 
        puts("allowed")
    else
      redirect_to root_path
    end
  end
    def index
      @meets = Meet.all
    end
  
  
    def about
    end
  
    def new
      @agenda = Agenda.new
      @meetid  = params[:id]
    end
  
    # POST /meets or /meets.json
    def create
      @agenda = Agenda.new(agenda_params)
        if @agenda.save
          redirect_to  home_new_path( :id => @agenda.meet_id )
        
        else
            puts("not sacae")
        end
    end
  
  
  
    private 
     
    def agenda_params
      params.require(:agenda).permit(:user_id , :content , :meet_id )
    end
  end
  