require 'spec_helper'

describe FbGraph2::Edge::Offers do
  context 'included in Page' do
    let(:page) { FbGraph2::Page.new('page_id').authenticate('page_token') }

    describe '#offers' do
      it 'should return an Array of FbGraph2::Offer' do
        offers = mock_graph :get, 'page_id/offers', 'page/offers', access_token: 'page_token' do
          page.offers
        end
        offers.should be_instance_of FbGraph2::Edge
        offers.should_not be_blank
        offers.each do |offer|
          offer.should be_instance_of FbGraph2::Offer
        end
      end
    end

    describe '#offer!' do
      it 'should return FbGraph2::Offer' do
        offer = mock_graph :post, 'page_id/offers', 'success_with_id', access_token: 'page_token', params: {
          title: 'Foobar',
          expiration_time: 10.days.from_now.to_s
        } do
          page.offer!(
            title: 'Foobar',
            expiration_time: 10.days.from_now
          )
        end
        offer.should be_instance_of FbGraph2::Offer
      end
    end
  end
end