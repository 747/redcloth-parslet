describe RedClothParslet::Parser::Inline do
  let(:parser) { described_class.new }
  let(:transform) { RedClothParslet::Transform.new }

  describe "#double_quoted_phrase_or_link" do
    it "should parse a basic link" do
      parser.double_quoted_phrase_or_link.should parse('"Google":http://google.com').with(transform).as(link("Google", {:href=>"http://google.com"}))
    end

    it "should parse link with attributes" do
      parser.double_quoted_phrase_or_link.should parse('"(appropriate)RedCloth":http://redcloth.org').with(transform).as(link("RedCloth", {:href=>"http://redcloth.org", :class=>"appropriate"}))
    end
  end

  context "link in context" do
    it { should parse(%{See "Wikipedia":http://wikipedia.org/ for more.}).with(transform).
         as(["See ", 
             link("Wikipedia", {:href=>"http://wikipedia.org/"}),
             " for more."])
    }
  end

  context "link at the end of a sentence" do
    it { should parse(%{Visit "Apple":http://apple.com/.}).with(transform).
         as(["Visit ", 
             link("Apple", {:href=>"http://apple.com/"}), 
             "."])
    }
  end

  context "in brackets" do
    it { should parse(%{"Wikipedia article about Textile":http://en.wikipedia.org/wiki/Textile_(markup_language)}).with(transform).
         as([link("Wikipedia article about Textile", {:href=>"http://en.wikipedia.org/wiki/Textile_(markup_language)"})])
    }
  end

  context "image link" do
    it { should parse(%{!openwindow1.gif!:http://hobix.com/}).with(transform).
         as([link(img([], {:src=>"openwindow1.gif", :alt => ""}), {:href => "http://hobix.com/"})])
    }
  end
end
