class MomsController < ApplicationController
  before_action :set_mom, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check


    
  def check
    if current_user.status == true 
        puts("allowed")
    else
      redirect_to root_path
    end
  end


  # GET /moms or /moms.json
  def index
    @moms = Mom.all.order( 'date DESC' )
  end

  # GET /moms/1 or /moms/1.json
  def show

  end

  # GET /moms/new
  def new
    @mom = Mom.new
    @id = params[:id]
    @meet = Meet.find(params[:id])
    @all_agenda = Agenda.where("meet_id = ?" , @id)
    20.times {@mom.actions.build}
    @exist1 = Mom.where("meet_id = ?", @meet.id)
    if !@exist1.empty?
      redirect_to home_see_your_url , notice: "Already Created -- "
    end
  end

  # GET /moms/1/edit
  def edit
    
  end

  # POST /moms or /moms.json
  def create
    @exist = Mom.where("meet_id = ?" , mom_params[:meet_id] ).empty?
    if @exist == true
          @mom = Mom.new(mom_params)
          respond_to do |format|
            if @mom.save
              format.html { redirect_to meets_path(@mom.meet_id), notice: "Minutes was successfully created." }
              format.json { render :show, status: :created, location: @mom }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @mom.errors, status: :unprocessable_entity }
            end
          end
      else 
        redirect_to moms_url
      end
  end

  # PATCH/PUT /moms/1 or /moms/1.json
  def update
    respond_to do |format|
      if @mom.update(mom_params)
        format.html { redirect_to mom_url(@mom), notice: " successfully updated." }
        format.json { render :show, status: :ok, location: @mom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moms/1 or /moms/1.json
  def destroy
    @mom.destroy
    respond_to do |format|
      format.html { redirect_to moms_url, notice: "Mintues was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mom
      @mom = Mom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mom_params
      params.require(:mom).permit(:date, :calledby, :descrption, :title, :venue, :callby_id, :meet_id, :attendby, :report , actions_attributes: %i[ id description budget deadline appointed_person  _destroy])
    end
end
