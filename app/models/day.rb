class Day < ActiveRecord::Base
    belongs_to :day
    has_many :schedule, dependent: :destroy
end
