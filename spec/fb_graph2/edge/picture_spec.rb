require 'spec_helper'

describe FbGraph2::Edge::Picture do
  context 'included in User' do
    describe '#picture' do
      let(:me) { FbGraph2::User.me('token') }

      it do
        mock_graph :get, 'me/picture', 'user/picture', access_token: 'token', params: {
          redirect: false
        } do
          me.picture
        end.should be_instance_of FbGraph2::Struct::Picture
      end

      context 'when cached' do
        let(:me_with_picture) do
          mock_graph :get, 'me', 'user/with_picture', access_token: 'token', params: {
            fields: 'picture'
          } do
            me.fetch fields: 'picture'
          end
        end

        context 'with option params' do
          it 'should not use cache' do
            mock_graph :get, '579612276/picture', 'user/picture', access_token: 'token', params: {
              redirect: false,
              type: 'square'
            } do
              me_with_picture.picture :square
            end
          end
        end

        context 'without option params' do
          it 'should use cache' do
            expect do
              me_with_picture.picture
            end.not_to request_to '579612276/picture'
          end
        end
      end
    end
  end
end