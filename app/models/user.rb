class User < ActiveRecord::Base
  has_many :shifts
end
