require 'spec_helper'

describe FbGraph2::Edge::Comments do
  context 'included in Post' do
    let(:post) { FbGraph2::Post.new('post_id').authenticate('token') }

    describe '#comments' do
      context 'when cached' do
        let(:fetched) do
          mock_graph :get, 'post_id', 'post/liked_and_commented', access_token: 'token' do
            post.fetch
          end
        end

        context 'without params' do
          it 'should not call API' do
            expect do
              fetched.comments
            end.not_to request_to "#{fetched.id}/comments"
          end
        end

        context 'with params' do
          it 'should call API' do
            expect do
              fetched.comments no_cache: true
            end.to request_to "#{fetched.id}/comments"
          end
        end
      end
    end
  end
end