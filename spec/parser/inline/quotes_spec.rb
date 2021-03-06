describe RedClothParslet::Parser::Inline do
  let(:parser) { described_class.new }
  let(:transform) { RedClothParslet::Transform.new }

  describe "#double_quoted_phrase" do
    it "should consume a double-quoted phrase" do
      parser.double_quoted_phrase.should parse('"Wow"')
    end
  end
  describe "#double_quoted_phrase" do
    it "should consume a double-quoted phrase" do
      parser.double_quoted_phrase.should parse('"(Berk.) Hilton"')
    end
  end
  describe "quotes" do
    it { should parse(%Q{"Hey!"}).with(transform).
         as(double_quoted_phrase("Hey!"))
    }

    it { should parse(%Q{["(Berk.) Hilton"]}).with(transform).
         as(["[", double_quoted_phrase("(Berk.) Hilton"), "]"])
    }

    it { should parse(%{"Red\nCloth"}).with(transform).
         as(double_quoted_phrase("Red\nCloth"))
    }
  end
end
