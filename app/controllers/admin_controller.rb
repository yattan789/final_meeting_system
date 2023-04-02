class AdminController < ApplicationController
    before_action :check, except: [:sign_out2]    
    def new
        @user = User.new
    end
    
    def sign_out2
      reset_session
      redirect_to root_path
    end

    def create
        @user = User.new(user_params)
        if @user.save
          redirect_to admin_index_path
        else
            redirect_to admin_index_path
        end
    end
    
    def index
      @users = User.all
    end

    def edit
        @user = User.find(params[:id])
    end

    
    def check
      if current_user.role == "admin" 
          puts("allowed")
      else
        redirect_to root_path
      end
    end


    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to admin_index_path, notice: "User updated successfully"
        else
          render 'edit'
        end
    end
      
    private

    def user_params
        params.require(:user).permit( :email, :role , :status )
    end

end
  