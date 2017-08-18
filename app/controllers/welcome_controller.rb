class WelcomeController < ApplicationController
    def index
        @user = User.new
    end
    
    # User's information saving action
    def create
        @user = User.new(user_params)
        session[:id] = user_params[:id]
        begin
            respond_to do |format|
                if @user.save
                    format.html { redirect_to '/setting', notice: 'User was successfully created.' }
                    format.json { render action: '/setting', status: :created, location: @user }
                else
                    format.html { render action: '/' }
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                end
            end
        rescue ActiveRecord::RecordNotUnique
            redirect_to '/main'
        end
    end
    # Already exist user
    def session_rec
        session[:id] = user_params[:id]
        redirect_to '/main'
    end
    
    def setting
        @user = User.find(session[:id])
        @username = @user[:name]
    end
    # Saving nickname & move to /main
    def update_name
        # Updating user nickname part
        @user = User.find(session[:id])
        @user.update(name: params.require(:user).permit(:name)[:name])
        
        # Create data in days table
        date = Time.now + 32400
        @day = @user.days.create(uid: @user[:uid], name: @user[:name], day: date.strftime("%Y-%m-%d"))

        redirect_to '/main'
    end
    
    private
        def user_params
            params.require(:user).permit(:id, :uid, :name, :snstype)
        end
end