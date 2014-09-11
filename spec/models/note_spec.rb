require 'spec_helper'

describe Note do
  it { should validate_presence_of :value }

  describe ".similar_notes" do
    let(:note) { FactoryGirl.create(:note) }
    it "should return all notes when given nil" do
      Note.similar_notes(nil).should == [note]
    end

    it "should return notes with the partial note given" do
      Note.similar_notes("est").should == [note]
    end

    it "should not return notes that don't match the partial given" do
      Note.similar_notes("Some note that is different from the note factory").should be_empty
    end
  end

  describe ".ordered_by" do
    let(:notes) do
      n1 = n2 = nil

      Timecop.freeze(2008, 7, 1, 12, 0, 0) do
        n1 = FactoryGirl.create(:note)
      end

      Timecop.freeze(2008, 7, 1, 12, 30, 0) do
        n2 = FactoryGirl.create(:note)
      end
      n3 = FactoryGirl.create(:note)
      
      [n1, n2, n3]
    end

    let(:alpha_notes) do
      [FactoryGirl.create(:note, value: 'All your base are belong to us!'), FactoryGirl.create(:note, value: 'I FEEL you mon!'), FactoryGirl.create(:note, value: 'Vi sitter i ventrilo och spelar DotA')]
    end

    context "value" do
      it "should sort by note values" do
        Note.ordered_by(:value, :asc).should == alpha_notes
      end
    end

    context "created" do
      it "should sort by created time" do
        Note.ordered_by(:created, :asc).should == notes
      end
    end
    
    context "updated" do
      it "should sort by updated time" do
        Note.ordered_by(:updated, :asc).should == notes
      end
    end
    
    context "email" do
      let(:u1) { FactoryGirl.create(:user) }
      let(:u2) { FactoryGirl.create(:user) }
      before do
        u1.notes << notes[1]
        u2.notes << notes[2]
      end

      it "should sort by users associated with the notes" do
        Note.ordered_by(:email, :asc).should == notes
      end
    end
  end
end