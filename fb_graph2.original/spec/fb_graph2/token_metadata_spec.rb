require 'spec_helper'

describe FbGraph2::TokenMetadata do
  let(:app_token) do
    attributes = mock_json 'token_metadata/app_token'
    FbGraph2::TokenMetadata.new attributes[:data]
  end
  let(:user_token) do
    attributes = mock_json 'token_metadata/user_token'
    FbGraph2::TokenMetadata.new attributes[:data]
  end
  let(:page_token) do
    attributes = mock_json 'token_metadata/page_token'
    FbGraph2::TokenMetadata.new attributes[:data]
  end
  let(:invalid_token) do
    attributes = mock_json 'token_metadata/invalid_token'
    FbGraph2::TokenMetadata.new attributes[:data]
  end

  context 'when app_token' do
    subject { app_token }
    its(:app_token?) { should == true }
    its(:user_token?) { should == false }
    its(:page_token?) { should == false }
  end

  context 'when user_token' do
    subject { user_token }
    its(:app_token?) { should == false }
    its(:user_token?) { should == true }
    its(:page_token?) { should == false }
  end

  context 'when page_token' do
    subject { page_token }
    its(:app_token?) { should == false }
    its(:user_token?) { should == false }
    its(:page_token?) { should == true }
  end

  context 'when valid' do
    subject { user_token }
    its(:valid?) { should == true }
  end

  context 'when invalid' do
    subject { invalid_token }
    its(:valid?) { should == false }
  end
end