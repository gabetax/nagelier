require 'time'

module Nagelier
  class ArduinoStatisticsQuery

    START_OF_DAY =  '8:00'
    END_OF_DAY   = '22:00'

    ANGRY = 0               # Less than 50% of goal for time of day
    PROGRESS = (1..254)   # 50% = 1, 75% = 128, 99% = 254
    HAPPY = 255             # goal for time of day met

    def initialize activity
      @activity = activity
    end

    def output_byte_for_arduino
      percentage = percentage_of_step_goal_for_time_of_day
      if percentage < 0.50
        ANGRY
      elsif percentage >= 1.0
        HAPPY
      else
        ((percentage - 0.50) * 2 * PROGRESS.max).to_i
      end.chr
    end

    def percentage_of_step_goal_for_time_of_day
      percentage_of_step_goal / percentage_of_day_complete
    end

    # @return 0.0..1.0
    def percentage_of_step_goal
      current_steps.to_f / step_goal
    end

    def current_steps
      @activity['summary']['steps']
    end

    def step_goal
      @activity['goals']['steps']
    end

    # @return 0.0..1.0
    def percentage_of_day_complete
      if Time.now < start_of_day
        0.0
      elsif Time.now > end_of_day
        1.0
      else
        (Time.now - start_of_day) / (end_of_day - start_of_day)
      end
    end

    def start_of_day
      start_of_day ||= Time.parse START_OF_DAY
    end

    def end_of_day
      end_of_day ||= Time.parse END_OF_DAY
    end
  end
end
