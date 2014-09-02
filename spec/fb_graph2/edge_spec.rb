require 'spec_helper'

describe FbGraph2::Edge do
  let(:me) { FbGraph2::User.me 'access_token' }
  let(:post) { FbGraph2::Post.new 'post_id', access_token: 'access_token' }
  let(:feed) do
    mock_graph :get, 'me/feed', 'user/feed', access_token: 'access_token' do
      me.feed
    end
  end
  let(:comments) do
    mock_graph :get, 'post_id/comments', 'post/comments_with_summary', access_token: 'access_token' do
      post.comments
    end
  end

  describe 'summary' do
    subject { comments }
    its(:summary) { should include order: 'chronological', total_count: 4 }
    its(:total_count) { should == 4 }
  end

  describe 'pagination' do
    context 'when next/previous-url-based' do
      describe 'next' do
        context 'when next page exists' do
          it 'should fetch next page' do
            feed.collection.next.should match(limit: '25', until: '1400651347')
            _next_ = mock_graph :get, 'me/feed', 'blank_collection', access_token: 'access_token', params: {
              limit: 25,
              until: '1400651347'
            } do
              feed.next
            end
            _next_.should be_instance_of FbGraph2::Edge
          end
        end

        context 'otherwise' do
          let(:without_next) do
            mock_graph :get, 'me/feed', 'blank_collection', access_token: 'access_token', params: {
              limit: 25,
              until: '1400651347'
            } do
              feed.next
            end
          end

          it do
            without_next.collection.next.should be_blank
            without_next.next.should be_blank
          end
        end
      end

      describe 'previous' do
        context 'when previous page exists' do
          it 'should fetch previous page' do
            feed.collection.previous.should match(limit: '25', since: '1401410484')
            previous = mock_graph :get, 'me/feed', 'blank_collection', access_token: 'access_token', params: {
              limit: 25,
              since: '1401410484'
            } do
              feed.previous
            end
            previous.should be_instance_of FbGraph2::Edge
          end
        end

        context 'otherwise' do
          let(:without_previous) do
            mock_graph :get, 'me/feed', 'blank_collection', access_token: 'access_token', params: {
              limit: 25,
              since: '1401410484'
            } do
              feed.previous
            end
          end

          it do
            without_previous.collection.previous.should be_blank
            without_previous.previous.should be_blank
          end
        end
      end
    end

    context 'when cursors-based' do
      describe 'next' do
        context 'when after cursor exists' do
          it 'should fetch next page' do
            comments.collection.after.should == 'NA=='
            _next_ = mock_graph :get, 'post_id/comments', 'blank_collection', access_token: 'access_token', params: {
              after: 'NA=='
            } do
              comments.next
            end
            _next_.should be_instance_of FbGraph2::Edge
          end
        end

        context 'otherwise' do
          let(:without_next) do
            mock_graph :get, 'post_id/comments', 'blank_collection', access_token: 'access_token', params: {
              after: 'NA=='
            } do
              comments.next
            end
          end

          it do
            without_next.collection.after.should be_blank
            without_next.next.should be_blank
          end
        end
      end

      describe 'previous' do
        context 'when before cursor exists' do
          it 'should fetch previous page' do
            comments.collection.before.should == 'MQ=='
            previous = mock_graph :get, 'post_id/comments', 'blank_collection', access_token: 'access_token', params: {
              before: 'MQ=='
            } do
              comments.previous
            end
            previous.should be_instance_of FbGraph2::Edge
          end
        end

        context 'otherwise' do
          let(:without_previous) do
            mock_graph :get, 'post_id/comments', 'blank_collection', access_token: 'access_token', params: {
              before: 'MQ=='
            } do
              comments.previous
            end
          end

          it do
            without_previous.collection.before.should be_blank
            without_previous.previous.should be_blank
          end
        end
      end
    end
  end
end