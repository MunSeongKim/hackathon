class Day < ActiveRecord::Base
    belongs_to :users
    has_many :schedules, dependent: :destroy
end
