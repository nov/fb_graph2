require 'spec_helper'

describe FbGraph2::User do
  describe '.me' do
    it 'should not call API' do
      expect do
        me = described_class.me 'token'
        me.should be_instance_of described_class
      end.not_to request_to 'me'
    end

    context 'when fetched' do
      it 'should call API' do
        me = mock_graph :get, 'me', 'user/me' do
          described_class.me('token').fetch
        end
        me.should be_instance_of described_class
      end

      context 'when ext attrs included' do
        it 'should success to parse' do
          me = mock_graph :get, 'me', 'user/me_with_ext_attrs' do
            described_class.me('token').fetch
          end
          [
            :age_range, :context, :currency, :devices
          ].each do |key|
            me.send(key).should be_present
          end
        end
      end
    end
  end
end