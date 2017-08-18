class MainController < ApplicationController
    def main
        @user = User.find(session[:id])
        @username = @user[:name]
        
        @firstDate = Day.order(day: :asc).find_by(user_id: session[:id])[:day].to_s.split("-")[2]
        @lastDate = Day.order(day: :desc).find_by(user_id: session[:id])[:day].to_s.split("-")[2]
        
        # For checking first comming & searching schedule is related today
        @days = Day.order(day: :desc).find_by(user_id: session[:id], day: params[:date])
        
        @diary = @days[:diary]
        
        @date = @days[:day].to_s
        @year = @date.split("-")[0];
        @month = @date.split("-")[1];
        @day = @date.split("-")[2];
        
        # Part of checking first comming
        @goal = @days[:goal]
        if @goal.nil?
            @goal = "처음 오셨군요..."
        else 
            @goal = @goal.split("!")
        end
        
        # Part of rendering schedule related day
        date = @days[:day]
        @sc = Schedule.order(id: :desc).where(day: date).select(:id, :day, :times, :title, :content, :check).to_a
        
        # For graph is about goal of this week
        checkCnt = Schedule.where(day: date, check: true).count
        totalCnt = Schedule.where(day: date).count
        if totalCnt != 0
            @scheduleRate = ((checkCnt.to_f / totalCnt.to_f) * 100).to_i
        else
            @scheduleRate = 0
        end
        
        # For input form
        @schedule = Schedule.new
        @editSchedule = Schedule.new
    end
    
    # Create new schedule
    def new_schedule
        # Getting Days model object for create schedule
        paramDay = schedule_params[:day]
        findDay = Day.find_by(day: paramDay)
        
        # create schedule
        @schedule = findDay.schedules.create(schedule_params)
        
        redirect_to "/main/#{findDay[:day]}"
    end
    
    def save_check
        @schedule = Schedule.find(params[:id]).update(check: true)
        
        redirect_to "/main/#{@schedule[:day]}"
    end
    
    def delete_schedule
        Schedule.find(params[:id]).destroy
        
        redirect_to "/main/#{params[:day]}"
    end
    
    def update_schedule
        @schedule = Schedule.find(params[:editId]).update(title: params[:editTitle], content: params[:editContent], times: params[:editTimes])
        
        redirect_to "/main/#{@schedule[:day]}"
    end
    
    def new_diary
        @days = Day.order(day: :desc).find_by(user_id: session[:id])
        @days.update(diary: params[:diary], score: params[:score])
        @user = User.find(session[:id])
        @user.days.create(uid: @user[:uid], name: @user[:name], day: @days[:day]+1, goal: params[:goals])

        redirect_to "/main/#{@days[:day]+1}"
    end
    
    private
        def schedule_params
            params.require(:schedule).permit(:title, :content, :times, :day)
        end
end
