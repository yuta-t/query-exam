class Shift < ActiveRecord::Base
  belongs_to :user

  def self.make_random_data
    users = User.all
    dates = ['2015-08-27', '2015-08-28', '2015-08-29']
    start_times = [11, 13, 15]

    users.each do |user|
      dates.each do |date|
        start_time = start_times[rand(3)]

        rand(5).times do
          user.shifts.create(date: date, start_time: start_time)
          start_time += 2
        end
      end
    end
  end
end
