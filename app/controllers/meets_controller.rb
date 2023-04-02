class MeetsController < ApplicationController
  before_action :set_meet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check
  before_action :check2 , only: %i[ new create  ]   
 
  def check2
    if current_user.role == "dean" || current_user.role == "director" 
        puts("allowed")
    else
      redirect_to root_path , notice => "Not allowed to create meetings"
    end

  end
    
  def check
    if current_user.status == true 
        puts("allowed")
    else
      redirect_to root_path
    end
  end



  def index
    @meets = Meet.where(  "user_id = ?" , current_user.id  )
  end

  def show
    @all_agenda = Agenda.where( "meet_id = ?" , @meet.id )
    @mom = Mom.where( " meet_id = ? " ,@meet.id )
    @action = Action.where( " mom_id = ? " ,@mom.ids )

    if @meet.type2 ==1 # Dean Meeting
      @Participents=User.where(role:["Director","Dean"])
    elsif @meet.type2 ==2 # Hod 
      @Participents=User.where(role:["Director","Hod"])
    elsif @meet.type2 ==3 # Hod & Chairpersons 
      @Participents=User.where(role:["Director","Hod","Chairperson"])
    end
#pdf 
    respond_to do |format|
      format.html
      format.pdf do
        pdf=Prawn::Document.new(:page_size => "A4", :page_layout => :portrait)     
        #pdf.stroke_axis
        pdf.image("./app/assets/images/logo-white.jpg",width:400,height:50,position: :center)
        pdf.move_down(10)
        pdf.stroke_horizontal_rule()
        pdf.move_down(10)
        pdf.font('Helvetica', size: 18)
        pdf.text( "<u>Minutes of Meeting</u>",align: :center,inline_format: true)
        pdf.font('Times-Roman', size: 12)
        pdf.move_down(10)
        pdf.text "Meeting Title   :#{@meet.title}"
        pdf.move_down(5)
        pdf.text "Meeting Date    :#{@meet.date.strftime("%d-%m-%Y")}"
        pdf.move_down(5)
        pdf.text "Meeting Description    :#{@meet.description}"
        pdf.move_down(5)
        pdf.text "For    :#{
          

        if @meet.type2 ==1 # Dean Meeting
            "Dean Meeting"
        elsif @meet.type2 ==2 # Hod 
            "Hod Meeting"
        elsif @meet.type2 ==3 # Hod & Chairpersons 
            "Hod Chairperson Meeting"
        end        
        
        }"
        pdf.move_down(5)
        #pdf.text "Meeting Venue    :#{@mom.venue}"      
        venue="";
        report="";
        @mom.each do |item|
          venue=item.venue
          report=item.report
        end
        pdf.text("Meeting Venue    :#{venue}")
        pdf.font('Helvetica', size: 14)
        pdf.text("<u>Agenda</u>",align: :left,inline_format: true,indent_paragraphs: 60) 
        pdf.font('Times-Roman', size: 12)
        slno=1
        pdf.move_down(10)
        @all_agenda.each do |item|
          pdf.text("#{slno} : #{item.content}")
          pdf.move_down(5)
          slno+=1
        end
        pdf.move_down(10)
        pdf.font('Helvetica', size: 14)
        pdf.text("<u>Decisions Taken</u>",align: :left,inline_format: true,indent_paragraphs: 60) 
        pdf.font('Times-Roman', size: 12)
        slno=1
        head_row=["Sl NO", "Description", "Budget", "Charge Assigned","Dead Line"]
        line_item_rows=[head_row]
        @action.each do |item|
          line_item_rows.push([slno,item.description, item.budget, item.appointed_person, item.deadline])
            slno+=1
        end
        pdf.move_down(20)
        pdf.table(line_item_rows,:header => true,:column_widths => [30,150, 100, 100,100])
        pdf.move_down(10)
        pdf.font('Helvetica', size: 16)
        pdf.text("<u>Report</u>",align: :left,inline_format: true,indent_paragraphs: 60) 
        pdf.font('Times-Roman', size: 12)
        pdf.text("#{report}",indent_paragraphs: 60)

        send_data pdf.render ,filename:"Meeting_Minutes#{@meet.title}_#{@meet.date.strftime("%d-%m-%Y")}.pdf",
        type:"application/pdf",disposition:"inline"
       
      end
      end




  end

  def new
    @meet = Meet.new
  end

  def edit
      @all_agenda = Agenda.where("meet_id = ?" , @meet.id)
  end

  def create
    @meet = Meet.new(meet_params)
    respond_to do |format|
      if @meet.save
        format.html { redirect_to meet_url(@meet), notice: "Meeting was successfully created." }
        format.json { render :show, status: :created, location: @meet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meet.update(meet_params)
        format.html { redirect_to meet_url(@meet), notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Mom.where(:meet_id => @meet.id).destroy_all
    @meet.destroy
    respond_to do |format|
      format.html { redirect_to meets_url, notice: "Meeting + Agendas was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_meet
      @meet = Meet.find(params[:id])
    end

    def meet_params
      params.require(:meet).permit(:user_id, :date, :title, :description ,:type2)
    end
end
