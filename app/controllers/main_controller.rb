class MainController < ApplicationController
    def main
        @user = User.find(session[:id])
        @username = @user[:name]
        
        @goal = Day.find_by(uid: session[:id])[:goal]
        if @goal.nil?
            @goal = "처음 오셨군요..."
        else 
            @goal = @goal.split("!")
        end
        
        
        date = Day.find_by(uid: session[:id])
        @sc = Schedule.where(day: date.day).pluck(:times, :title, :content)
        
        @schedule = Schedule.new
    end
    
    def new_schedule
        findDay = Day.find_by(uid: session[:id])[:day]
        
        @schedule = Schedule.find_by(day: findDay)
        
        if @schedule.nil?
            @schedule = Schedule.new
            @schedule[:title] = schedule_params[:title]
            @schedule[:content] = schedule_params[:content]
            @schedule[:times] = schedule_params[:times]
            @schedule[:day] = findDay
        else
            @schedule[:title] = schedule_params[:title]
            @schedule[:content] = schedule_params[:content]
            @schedule[:times] = schedule_params[:times]
        end
        
        begin
            respond_to do |format|
                if @schedule.save
                    format.html { redirect_to '/main', notice: 'Schedule was successfully created.' }
                    format.json { render action: '/main', status: :created, location: @schedule }
                else
                    format.html { render action: '/main' }
                    format.json { render json: @schedule.errors, status: :unprocessable_entity }
                end
            end
        end
    end
    
    private
        def schedule_params
            params.require(:schedule).permit(:title, :content, :times)
        end
end
