require 'spec_helper'

describe Product do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should_not allow_value(-1).for(:cost) }
  it { should_not allow_value(0).for(:cost) }
  it { should allow_value(1).for(:cost) }

  let(:product) { FactoryGirl.create(:product) }

  describe "#valid?" do
    it "valid factory" do
      FactoryGirl.build(:product).valid?.should be_true
    end
  end

  describe ".similar_names" do
    it "should return all products when given nil" do
      Product.similar_names(nil).should == [product]
    end

    it "should return products with the partial name given" do
      Product.similar_names("aas").should == [product]
    end

    it "should not return products that don't match the partial name given" do
      Product.similar_names("Software as a Service").should be_empty
    end
  end

  describe ".similar_descriptions" do
    it "should return all products when given nil" do
      Product.similar_descriptions(nil).should == [product]
    end

    it "should return products with the partial name given" do
      Product.similar_descriptions("serv").should == [product]
    end

    it "should not return products that don't match the partial name given" do
      Product.similar_descriptions("SaaS").should be_empty
    end
  end

  describe ".ordered_by" do
    let(:alpha_name_products) do
      [FactoryGirl.create(:product, name: 'Coffee', description: 'cafinated beverage'), 
        FactoryGirl.create(:product, name: 'Expresso', description: 'cafinated beverage'), 
        FactoryGirl.create(:product, name: 'Kahlua', description: 'cafinated beverage')]
    end

    context "name" do
      it "should sort by product name" do
        Product.ordered_by(:name, :asc).should == alpha_name_products
      end
    end

    let(:alpha_description_products) do
      [FactoryGirl.create(:product, name: 'Website Developer', description: 'ASP.NET w/ C#'), 
        FactoryGirl.create(:product, name: 'Website Developer', description: 'Node.js w/ HTML5 & Knockout.js'), 
        FactoryGirl.create(:product, name: 'Website Developer', description: 'Ruby on Rails w/ JQuery')]
    end

    context "description" do
      it "should sort by product description" do
        Product.ordered_by(:description, :asc).should == alpha_description_products
      end
    end

    let(:cost_products) do
      [FactoryGirl.create(:product, cost: 1), 
        FactoryGirl.create(:product, cost: 2), 
        FactoryGirl.create(:product, cost: 42)]
    end

    context "cost" do
      it "should sort by product cost" do
        Product.ordered_by(:cost, :asc).should == cost_products
      end
    end

    let(:products) do
      p1 = p2 = nil

      Timecop.freeze(2008, 7, 1, 12, 0, 0) do
        p1 = FactoryGirl.create(:product)
      end

      Timecop.freeze(2008, 7, 1, 12, 30, 0) do
        p2 = FactoryGirl.create(:product)
      end
      p3 = FactoryGirl.create(:product)
      
      [p1, p2, p3]
    end

    context "created" do
      it "should sort by created time" do
        Product.ordered_by(:created, :asc).should == products
      end
    end
    
    context "updated" do
      it "should sort by updated time" do
        Product.ordered_by(:updated, :asc).should == products
      end
    end
  end
end