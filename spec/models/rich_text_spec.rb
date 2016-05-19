require 'rails_helper'

SOURCE = 'This is a *markdown* field, so it _should_ respond to **all kinds** of markup, including more [complicated](https://github.com/) styles.'.freeze
RENDERED = "<p>This is a <em>markdown</em> field, so it <em>should</em> respond to <strong>all kinds</strong> of markup, including more <a href=\"https://github.com/\">complicated</a> styles.</p>\n".freeze

RSpec.describe RichText do
  let(:rich_text) { described_class.new(SOURCE, RENDERED) }
  let(:from_mongo) { { source: SOURCE, rendered: RENDERED } }

  subject { rich_text }

  it { should respond_to(:source) }
  it { should respond_to(:rendered) }
  it { should respond_to(:blank?) }
  it { should respond_to(:mongoize) }

  it { expect(rich_text.blank?).to eq(false) }

  it { expect(rich_text.rendered).to eq(RENDERED) }

  it { expect(rich_text.mongoize).to eq(from_mongo) }

  context 'using class methods' do
    it { expect(described_class.mongoize(rich_text)).to eq(rich_text.mongoize) }
    it { expect(described_class.mongoize(from_mongo)).to eq(rich_text.mongoize) }
    it { expect(described_class.mongoize(from_mongo[:source])).to eq(rich_text.mongoize) }
    it { expect(described_class.mongoize(1)).to eq(1) }

    it { expect(described_class.demongoize(nil).as_json).to eql(described_class.new(nil).as_json) }
    it { expect(described_class.demongoize(from_mongo).as_json).to eql(rich_text.as_json) }

    it { expect(described_class.evolve(rich_text)).to eq(rich_text.mongoize) }
    it { expect(described_class.evolve(1)).to eq(1) }
  end
end
