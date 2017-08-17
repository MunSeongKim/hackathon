class WelcomeController < ApplicationController
    def index
        @user = User.new
    end
    
    # User's information saving action
    def create
        @user = User.new(user_params)
        
        begin
            respond_to do |format|
                if @user.save
                    format.html { redirect_to '/logout', notice: 'User was successfully created.' }
                    format.json { render action: '/setting', status: :created, location: @user }
                else
                    format.html { render action: '/' }
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                end
            end
        rescue ActiveRecord::RecordNotUnique
            redirect_to '/logout'
        end
    end
    
    private
        def user_params
            params.require(:user).permit(:id, :uid, :name, :snstype)
        end
end