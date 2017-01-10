require 'spec_helper'
describe 'posgresql' do
  context 'with default values for all parameters' do
    it { should contain_class('posgresql') }
  end
end
