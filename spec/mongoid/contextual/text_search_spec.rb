require "spec_helper"

describe Mongoid::Contextual::TextSearch do

  before(:all) do
    Word.create_indexes
  end

  after(:all) do
    Word.remove_indexes
  end

  describe "#initialize" do

    let(:collection) do
      Word.collection
    end

    let(:criteria) do
      Word.limit(100)
    end

    let(:search) do
      described_class.new(collection, criteria, "phase")
    end

    it "sets the collection" do
      expect(search.collection).to eq(collection)
    end

    it "sets the criteria" do
      expect(search.criteria).to eq(criteria)
    end

    it "sets the text command" do
      expect(search.command[:text]).to eq(collection.name)
    end

    it "sets the text search parameter" do
      expect(search.command[:search]).to eq("phase")
    end

    it "sets the criteria" do
      expect(search.command[:filter]).to be_empty
    end

    it "sets the limit" do
      expect(search.command[:limit]).to eq(100)
    end
  end
end