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

      context 'otherwise' do
        it 'should return an Array of FbGraph2::Post' do
          comments = mock_graph :get, 'post_id/comments', 'post/comments', access_token: 'token' do
            post.comments
          end
          comments.should be_instance_of FbGraph2::Edge
          comments.should_not be_blank
          comments.each do |comment|
            comment.should be_instance_of FbGraph2::Comment
          end
        end
      end

      context 'when summary requested' do
        it 'should be summarized' do
          comments = mock_graph :get, 'post_id/comments', 'post/comments_with_summary', access_token: 'token', params: {
            summary: true
          } do
            post.comments(summary: true)
          end
          comments.summary.should include order: 'chronological', total_count: 4
          comments.total_count.should == 4
        end
      end
    end

    describe '#comment!' do
      it 'should return FbGraph2::Post with posted params' do
        comment = mock_graph :post, 'post_id/comments', 'success_with_id', access_token: 'token' do
          post.comment! message: 'hello'
        end
        comment.should be_instance_of FbGraph2::Comment
        comment.id.should == 'created_object_id'
        comment.message.should == 'hello'
      end
    end
  end
end