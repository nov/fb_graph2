require 'spec_helper'

describe FbGraph2::Edge::Roles do
  context 'included in App' do
    let(:app) { FbGraph2::App.app('app_token') }

    describe '#roles' do
      it 'should return an Array of FbGraph2::Struct::Role' do
        roles = mock_graph :get, 'app/roles', 'app/roles', access_token: 'app_token' do
          app.roles
        end
        roles.should be_instance_of FbGraph2::Edge
        roles.should_not be_blank
        roles.each do |role|
          role.should be_instance_of FbGraph2::Struct::Role
        end
      end
    end
  end

  context 'included in Page' do
    let(:page) { FbGraph2::Page.new('page_id').authenticate('page_token') }

    describe '#roles' do
      it 'should return an Array of FbGraph2::User' do
        roles = mock_graph :get, 'page_id/roles', 'page/roles', access_token: 'page_token' do
          page.roles
        end
        roles.should be_instance_of FbGraph2::Edge
        roles.should_not be_blank
        roles.each do |role|
          role.should be_instance_of FbGraph2::User
        end
      end

      context 'when blank' do
        it 'should return a blank Array' do
          roles = mock_graph :get, 'page_id/roles', 'blank_collection', access_token: 'page_token' do
            page.roles
          end
          roles.should be_instance_of FbGraph2::Edge
          roles.should be_blank
        end
      end

      context 'when user context specified' do
        let(:user) { FbGraph2::User.new('user_id') }

        it 'should return a FbGraph2::User' do
          role = mock_graph :get, 'page_id/roles/user_id', 'page/roles_single', access_token: 'page_token' do
            page.roles user
          end
          role.should be_instance_of FbGraph2::User
        end

        context 'when blank' do
          it 'should return nil' do
            role = mock_graph :get, 'page_id/roles/user_id', 'blank_collection', access_token: 'page_token' do
              page.roles user
            end
            role.should be_nil
          end
        end
      end
    end
  end
end