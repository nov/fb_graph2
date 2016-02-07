require 'spec_helper'

describe FbGraph2::Struct::AppInsight do
  let(:app_insight) do
    FbGraph2::Struct::AppInsight.new(
      time: '2015-07-13T08:00:00+0000',
      value: '3'
    )
  end
  subject { app_insight }

  its(:time)  { should == Time.parse('2015-07-13T08:00:00+0000')  }
  its(:value) { should == '3' }
end
