class User < ActiveRecord::Base
    has_many :day, dependent: :destroy
end
