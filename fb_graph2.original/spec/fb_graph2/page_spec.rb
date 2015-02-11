require 'spec_helper'

describe FbGraph2::Page do
  context 'with optional fields' do
    subject { page }
    let(:page) do
      attributes = mock_json 'page/with_optional_fields'
      FbGraph2::Page.new attributes[:id], attributes
    end

    describe '#context' do
      subject { page.context }
      it { should be_instance_of FbGraph2::Struct::Context::PageContext }

      describe 'friends_who_like' do
        subject { page.context.friends_who_like }
        it { should be_instance_of FbGraph2::Collection }
        it { should be_blank }
        its(:total_count) { should == 14 }
        its(:summary) { should include :social_sentence }
      end
    end

    describe '#parking' do
      subject { page.parking }
      [:street, :lot, :valet].each do |key|
        its(key) { should be false }
      end
    end

    describe '#restaurant_services' do
      subject { page.restaurant_services }
      [:kids, :delivery, :catering, :waiter, :outdoor, :takeout].each do |key|
        its(key) { should be false }
      end
      [:groups, :reserve, :walkins].each do |key|
        its(key) { should be true }
      end
    end

    describe '#restaurant_specialties' do
      subject { page.restaurant_specialties }
      [:coffee, :drinks, :breakfast, :lunch].each do |key|
        its(key) { should be false }
      end
      [:dinner].each do |key|
        its(key) { should be true }
      end
    end

    describe '#payment_options' do
      subject { page.payment_options }
      [:cash_only, :discover].each do |key|
        its(key) { should be false }
      end
      [:amex, :mastercard, :visa].each do |key|
        its(key) { should be true }
      end
    end
  end
end