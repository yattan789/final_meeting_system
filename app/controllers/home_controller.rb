class HomeController < ApplicationController
  before_action :set_meet, only: %i[ delete  , delete2 ]
 
  def index
    @meets = Meet.all.order( 'date DESC' )
  end
  
  def index2 
    if current_user.role == "director" || current_user.role == "dean" || current_user.role == "admin"
      @meets = Meet.all.order( 'date DESC' )
    end
    
    if current_user.role == "hod" 
      @meets = Meet.where("(type2 = ? or type2 = ?)", 3, 2)
    end

    if current_user.role == "chairperson" 
      @meets = Meet.where(" type2 = ? " , 3 ).order( 'date DESC' )
    end
    
    
    if current_user.role == "help_person"
       redirect_to root_path , notice =>  "Not Authorized"
    end

  end

  def about
  end

  def see_your
    if current_user.role == "help_person"
        @meet = Meet.all.order( 'date DESC' )
    else
      redirect_to  root_path
    end
  end

  def new
    @agenda = Agenda.new
    @meetid  = params[:id]
    @meet = Meet.find(params[:id])
    @provide_agenda= Agenda.where("user_id = ? and meet_id = ? ", current_user.id , @meetid ) 
  end

  def delete
    @agenda.destroy 
    respond_to do |format|
      format.html { redirect_to home_new_path( :id => @agenda.meet_id ) , notice: "Agenda was successfully destroyed." }
    end
  end


  def delete2
    @agenda.destroy 
    respond_to do |format|
      format.html { redirect_to new_mom_path( :id => @agenda.meet_id ) , notice: "Agenda was successfully destroyed." }
    end
  end




  private 
  def set_meet
    @agenda = Agenda.find(params[:id])
    
  end

  def agenda_params
    params.require(:agenda).permit(:user_id , :content , :meet_id )
  end
end
