require_relative '../lib/archive_display'

RSpec.describe Jekyll do
  include described_class

  let(:config) { instance_double(Configuration) }
  let(:context) do
    context_ = instance_double(Liquid::Context)
    context_.config = config
    context_
  end

  it 'just a placeholder', skip: 'Not implemented' do
    expect(output).to eq('asdf')
  end
end
