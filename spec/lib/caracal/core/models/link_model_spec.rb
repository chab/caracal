require 'spec_helper'

describe Caracal::Core::Models::LinkModel do
  subject do 
    described_class.new do
      content     'Link Text'
      href        'http://www.google.com'
      style       'Fancy'
      color       '666666'
      size        20
      bold        false
      italic      false
      underline   true
    end
  end
  
  #-------------------------------------------------------------
  # Configuration
  #-------------------------------------------------------------

  describe 'configuration tests' do
    
    # accessors
    describe 'accessors' do
      it { expect(subject.link_content).to eq 'Link Text' }
      it { expect(subject.link_href).to eq 'http://www.google.com' }
      it { expect(subject.link_style).to eq 'Fancy' }
      it { expect(subject.link_color).to eq '666666' }
      it { expect(subject.link_size).to eq 20 }
      it { expect(subject.link_bold).to eq false }
      it { expect(subject.link_italic).to eq false }
      it { expect(subject.link_underline).to eq true }
    end
    
  end
  
  
  #-------------------------------------------------------------
  # Public Methods
  #-------------------------------------------------------------
  
  describe 'public method tests' do
    
    #=============== SETTERS ==========================
    
    # booleans
    describe '.bold' do
      before { subject.bold(true) }
      
      it { expect(subject.link_bold).to eq true }
    end
    describe '.italic' do
      before { subject.italic(true) }
      
      it { expect(subject.link_italic).to eq true }
    end
    describe '.underline' do
      before { subject.underline(true) }
      
      it { expect(subject.link_underline).to eq true }
    end
    
    # integers
    describe '.size' do
      before { subject.size(24) }
      
      it { expect(subject.link_size).to eq 24 }
    end
    
    # strings
    describe '.color' do
      before { subject.color('999999') }
      
      it { expect(subject.link_color).to eq '999999' }
    end
    describe '.content' do
      before { subject.content('Something Else') }
      
      it { expect(subject.link_content).to eq 'Something Else' }
    end
    describe '.href' do
      before { subject.href('http://www.plia.com') }
      
      it { expect(subject.link_href).to eq 'http://www.plia.com' }
    end
    describe '.style' do
      before { subject.style('Dummy') }
      
      it { expect(subject.link_style).to eq 'Dummy' }
    end
    
    
    #=============== VALIDATION ===========================
    
    describe '.valid?' do
      describe 'when required attributes provided' do
        it { expect(subject.valid?).to eq true }
      end
      [:content, :href].each do |prop|
        describe "when #{ prop } nil" do
          before do
            allow(subject).to receive("link_#{ prop }").and_return(nil)
          end
        
          it { expect(subject.valid?).to eq false }
        end
      end
    end
  
  end
  
end