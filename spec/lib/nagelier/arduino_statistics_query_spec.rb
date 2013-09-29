require_relative '../../../lib/nagelier/arduino_statistics_query'
require 'timecop'
require 'pry'

describe Nagelier::ArduinoStatisticsQuery do
  subject { Nagelier::ArduinoStatisticsQuery.new activity }
  let(:activity) do
    {
      'goals'   => { 'steps' => step_goal },
      'summary' => { 'steps' => steps }
    }
  end
  let(:step_goal) { 10_000 }
  let(:steps)     { 5_000  }

  describe "output_byte_for_arduino" do
    context "when happy" do
      before { subject.stub percentage_of_step_goal_for_time_of_day: 1.00 }
      its(:output_byte_for_arduino) { should == 255.chr }
    end
    context "when angry" do
      before { subject.stub percentage_of_step_goal_for_time_of_day: 0.49 }
      its(:output_byte_for_arduino) { should == 0.chr }
    end
    context "in progress" do
      before { subject.stub percentage_of_step_goal_for_time_of_day: 0.8 }
      its(:output_byte_for_arduino) { should == 152.chr }
    end
  end

  describe "percentage_of_step_goal_for_time_of_day" do
    specify do
      Timecop.freeze '22:00' do
        subject.percentage_of_step_goal_for_time_of_day.should == 0.5
      end
    end
  end

  describe "percentage_of_step_goal" do
    let(:step_goal) { 11_000 }
    let(:steps)     { 7_200  }
    its(:percentage_of_step_goal) { should be_within(0.1).of(0.65) }
  end

  describe "percentage_of_day_complete" do
    it "is 0 before the day starts" do
      Timecop.freeze Time.parse('1:00') do
        subject.percentage_of_day_complete.should == 0.0
      end
    end

    it "is 1 after the day ends" do
      Timecop.freeze Time.parse('23:00') do
        subject.percentage_of_day_complete.should == 1.0
      end
    end

    it "progresses through the day" do
      Timecop.freeze Time.parse('12:00') do
        subject.percentage_of_day_complete.should be_within(0.1).of(0.28)
      end
    end
  end
end
