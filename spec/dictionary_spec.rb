require 'dictionary'
require 'byebug'
require 'fakeweb'
require 'spec_helper'
require 'rspec/collection_matchers'

describe Dictionary do
  describe "combinations" do
    context "When testing the Dictionary class" do
      it "The combinations method should return concerned " do
        message = Dictionary.new().combinations("6686787825")
        expect(message).to eq [["noun", "struck"], ["onto", "struck"], ["motor", "truck"], ["motor", "usual"], ["nouns", "truck"], ["nouns", "usual"], "motortruck"]
      end

      it "The say_hello method should return 'Hello World'" do
        message = Dictionary.new().combinations("6686")
        expect(message).to eq []
      end
    end
  end
end

