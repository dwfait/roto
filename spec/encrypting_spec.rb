require 'spec_helper'

describe 'test' do
  specify 'the truth' do
    expect(Roto.the_truth).to eq(42)
  end
end
