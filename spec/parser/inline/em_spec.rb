describe RedClothParslet::Parser::Inline do
  let(:parser) { described_class.new }
  
  describe "#em" do
    it "should consume an emphasized word" do
      parser.em.should parse('_wow_')
    end

    it "should consume an emphasized phrase" do
      parser.em.should parse('_gee whiz!_')
    end
    
    it "should pass internal em_start as plain text" do
      parser.em.should parse('_Written by _why the lucky stiff_').
        as({:inline => "_", :content => [:s => "Written by _why the lucky stiff"]})
    end
    
    it "should not parse an emphasized phrase containing em_end" do
      parser.em.should_not parse('_the mouse_ has a tail_')
    end
    
  end
  
  context "em phrase" do
    it { should parse("_em phrase_").
      as([{:inline => "_", :content => [:s => "em phrase"]}]) }
    
    it "should parse an emphasized word surrounded by plain text" do
      subject.should parse("plain _em_ plain").
      as([{:s => "plain "}, 
          {:inline => "_", :content => [{:s => "em"}]},
          {:s => " plain"}])
    end
    
    it "should parse an emphasized phrase surrounded by plain text" do
      subject.should parse("plain _em phrase_ plain").
      as([{:s => "plain "}, 
          {:inline => "_", :content => [{:s => "em phrase"}]},
          {:s => " plain"}])
    end
    
    it "should allow an emphasized phrase at the end of a sentence before punctuation" do
      subject.should parse("Are you _fo' realz_?").
        as([{:s => "Are you "}, {:inline => "_", :content => [:s => "fo' realz"]}, {:s => "?"}])
    end

    it "should parse a phrase with underscored words that is not an emphasized phrase" do
      subject.should parse("The form_test_helper plugin was my first.").
        as([{:s => "The form_test_helper plugin was my first."}])
    end

    it "should parse a phrase that is not emphasized because it has space at the end" do
      subject.should parse("no _em _ here!").
        as([{:s => "no _em _ here!"}])
    end
    
    it "should parse a phrase that is not emphasized because it has space at the beginning" do
      subject.should parse("surely you _ can't_ be serious").
        as([{:s => "surely you _ can't_ be serious"}])
    end
  end
  
end