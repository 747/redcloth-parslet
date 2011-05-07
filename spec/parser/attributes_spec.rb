describe RedClothParslet::Parser::Attributes do
  let(:parser) { described_class.new }

  context "style" do
    it { should parse("{color:red;}").
      as([{:style=>"color:red;"}])
    }
  end
  
  context "style + class" do
    it { should parse('{color:red;}(my-class#myid)').
      as([{:style=>'color:red;'}, {:class=>'my-class', :id => 'myid'}])
    }
  end
  
  context "class + style" do
    it { should parse('(my-class#myid){color:red;}').
      as([{:class=>'my-class', :id => 'myid'}, {:style=>'color:red;'}])
    }
  end  
  
  context "class and alignment with class first" do
    it { should parse('(myclass)<').as([{:class=>'myclass'}, {:align=>'<'}]) }
    it { should parse('(myclass)<>').as([{:class=>'myclass'}, {:align=>'<'}, {:align=>'>'}]) }
    it { should parse('(myclass)>').as([{:class=>'myclass'}, {:align=>'>'}]) }
    it { should parse('(myclass))').as([{:class=>'myclass'}, {:padding=>')'}]) }
    it { should parse('(myclass)(').as([{:class=>'myclass'}, {:padding=>'('}]) }
    it { should parse('(myclass)()').as([{:class=>'myclass'}, {:padding=>'('}, {:padding=>')'}]) }
  end
    
    context "class and alignment with alignment first" do
      it { should parse('<(myclass)').as([{:align=>'<'}, {:class=>'myclass'}]) }
      it { should parse('<>(myclass)').as([{:align=>'<'}, {:align=>'>'}, {:class=>'myclass'}]) }
      it { should parse('>(myclass)').as([{:align=>'>'}, {:class=>'myclass'}]) }
      it { should parse(')(myclass)').as([{:padding=>')'}, {:class=>'myclass'}]) }
      it { should parse('((myclass)').as([{:padding=>'('}, {:class=>'myclass'}]) }
      it { should parse('()(myclass)').as([{:padding=>'('}, {:padding=>')'}, {:class=>'myclass'}]) }
    end
    
    context "id and alignment with id first" do
      it { should parse('(#myid)<').as([{:id=>'myid'}, {:align=>'<'}]) }
      it { should parse('(#myid)<>').as([{:id=>'myid'}, {:align=>'<'}, {:align=>'>'}]) }
      it { should parse('(#myid)>').as([{:id=>'myid'}, {:align=>'>'}]) }
      it { should parse('(#myid))').as([{:id=>'myid'}, {:padding=>')'}]) }
      it { should parse('(#myid)(').as([{:id=>'myid'}, {:padding=>'('}]) }
      it { should parse('(#myid)()').as([{:id=>'myid'}, {:padding=>'('}, {:padding=>')'}]) }
    end
    
    context "id and alignment with alignment first" do
      it { should parse('<(#myid)').as([{:align=>'<'}, {:id=>'myid'}]) }
      it { should parse('<>(#myid)').as([{:align=>'<'}, {:align=>'>'}, {:id=>'myid'}]) }
      it { should parse('>(#myid)').as([{:align=>'>'}, {:id=>'myid'}]) }
      it { should parse(')(#myid)').as([{:padding=>')'}, {:id=>'myid'}]) }
      it { should parse('((#myid)').as([{:padding=>'('}, {:id=>'myid'}]) }
      it { should parse('()(#myid)').as([{:padding=>'('}, {:padding=>')'}, {:id=>'myid'}]) }
    end
    
    context "aligns separated by class" do
      it { should parse('<(myclass)>').as([{:align=>'<'}, {:class=>'myclass'}, {:align=>'>'}]) }
      it { should parse('((myclass))').as([{:padding=>'('}, {:class=>'myclass'}, {:padding=>')'}]) }
    end
end