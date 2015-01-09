require 'spec_helper'

describe FbGraph2::Searchable do
  describe 'search' do
    context 'User' do
      it 'should return users' do
        users = mock_graph :get, 'search', 'search/user', access_token: 'token', params: {
          q: 'nov.matake',
          type: 'user'
        } do
          FbGraph2::User.search 'nov.matake', 'token'
        end
        users.should be_instance_of FbGraph2::Searchable::Result
        users.should_not be_empty
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
      end
    end
  end

  describe 'pagination' do
    context 'when first page' do
      let :page1 do
         mock_graph :get, 'search', 'search/user', access_token: 'token', params: {
          q: 'nov.matake',
          type: 'user'
        } do
          FbGraph2::User.search 'nov.matake', 'token'
        end
      end

      it 'should have next' do
        mock_graph :get, 'search', 'blank_collection', access_token: 'token', params: {
          q: 'nov.matake',
          type: 'user',
          __after_id: 'enc_AeyyBJc7uo9gY-nHN9-LM0yG_IKBN5nCmqdkG8b4Ql-COLTnpQ-2NUc-xSDK6VwPhsq2W9Ktnr0zf7dD25Bc9eKT',
          limit: 5000,
          offset: 5000
        } do
          page1.next
        end
      end

      it 'should have no previous' do
        page1.previous.should be_blank
      end
    end
  end
end