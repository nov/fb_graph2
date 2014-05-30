require 'spec_helper'

describe FbGraph2::Node do
  let(:klass) { FbGraph2::Node }
  let(:instance) { klass.new 'identifier' }

  context 'class' do
    subject { klass }
    it { should_not respond_to :register_attributes }
    it { should_not respond_to :registered_attributes }
    it { should_not respond_to :registered_attributes= }

    describe '.fetch' do
      it 'should call API' do
        expect do
          klass.fetch 'foo'
        end.to request_to '/foo'
      end
    end
  end

  context 'instance' do
    subject { instance }
    it { should_not respond_to :assign }

    describe '#initialize' do
      its(:id) { should == 'identifier' }
      its(:access_token) { should be_nil }
      its(:raw_attributes) { should be_nil }
    end

    describe '#authenticate' do
      before { instance.authenticate 'access_token' }
      its(:access_token) { should == 'access_token' }
    end

    describe '#destroy' do
      it 'should call API with DELETE method' do
        expect do
          instance.destroy
        end.to request_to 'identifier', :delete
      end
    end

    describe '#handle_response' do
      context 'when error' do
        context 'when valid json' do
          it 'should raise' do
            expect do
              mock_graph :get, 'identifier', 'error/400/2500', status: 400 do
                instance.fetch
              end
            end.to raise_error { |e|
              e.should be_instance_of RuntimeError
              e.message.should == mock_json('error/400/2500')
            }
          end
        end

        context 'when invalid json' do
          it 'should raise' do
            expect do
              mock_graph :get, 'identifier', 'error/invalid_format', status: 400 do
                instance.fetch
              end
            end.to raise_error { |e|
              e.should be_instance_of RuntimeError
              e.message.should == mock_json('error/invalid_format')
            }
          end
        end
      end
    end
  end
end