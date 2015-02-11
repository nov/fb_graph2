require 'spec_helper'

describe FbGraph2::Edge::Likes do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }

    describe '#likes' do
      it 'should return an Array of FbGraph2::Page' do
        likes = mock_graph :get, 'me/likes', 'user/likes', access_token: 'token' do
          me.likes
        end
        likes.should be_instance_of FbGraph2::Edge
        likes.should_not be_blank
        likes.each do |like|
          like.should be_instance_of FbGraph2::Page
        end
      end
    end

    describe '#liked?' do
      context 'when liked' do
        it do
          mock_graph :get, 'me/likes/page_id', 'user/likes', access_token: 'token' do
            me.liked? 'page_id'
          end.should be true
        end
      end

      context 'otherwise' do
        it do
          mock_graph :get, 'me/likes/page_id', 'blank_collection', access_token: 'token' do
            me.liked? 'page_id'
          end.should be false
        end
      end
    end
  end

  context 'included in Post' do
    let(:post) { FbGraph2::Post.new('post_id').authenticate('token') }

    describe '#likes' do
      context 'when cached' do
        let(:fetched) do
          mock_graph :get, 'post_id', 'post/liked_and_commented', access_token: 'token' do
            post.fetch
          end
        end

        context 'without params' do
          it 'should not call API' do
            expect do
              fetched.likes
            end.not_to request_to "#{fetched.id}/likes"
          end
        end

        context 'with params' do
          it 'should call API' do
            expect do
              fetched.likes no_cache: true
            end.to request_to "#{fetched.id}/likes"
          end
        end
      end

      context 'otherwise' do
        it 'should return an Array of FbGraph2::User' do
          likes = mock_graph :get, 'post_id/likes', 'post/likes', access_token: 'token' do
            post.likes
          end
          likes.should be_instance_of FbGraph2::Edge
          likes.should_not be_blank
          likes.each do |like|
            like.should be_instance_of FbGraph2::User
          end
        end
      end
    end

    describe '#like!' do
      it 'should return true' do
        mock_graph :post, 'post_id/likes', 'true', access_token: 'token' do
          post.like!
        end.should be true
      end
    end

    describe '#unlike!' do
      it 'should return true' do
        mock_graph :delete, 'post_id/likes', 'true', access_token: 'token' do
          post.unlike!
        end.should be true
      end
    end
  end
end