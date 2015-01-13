require "spec_helper"

describe "mongoid_auto_increment" do
  before(:each) do
    @book1 = Book.create :title => "The Rails Way"
    @book2 = Book.create :title => "The Ruby Programming Language "
    @book3 = Book.create :title => "Metaprogramming Ruby"
    @book4 = Book.create :title => "Agile Web Development with Rails", :sequence => 42

    @order1 = Order.create :description => "First Order"
    @order2 = Order.create :description => "Second Order"
    @order3 = Order.create :description => "Last Order"

    @post1 = Post.create :title => "First Post"
    @post2 = Post.create :title => "Second Post"
    @post3 = Post.create :title => "Last Post"

    @comment1 = @post1.comments.create :body => "First Comment"
    @comment2 = @post1.comments.create :body => "Second Comment"

    @invoice1 = Invoice.create :description => "First invoice"
    @invoice2 = Invoice.create :description => "Second invoice"
    @invoice3 = Invoice.create :description => "Third invoice"

    @author1 = Author.create :name => "John Smith"
  end

  describe "single auto-increment field" do
    it "should assign id 1 to the first book" do
      expect(@book1.sequence).to eq(1)
    end

    it "should assign id 2 to the second book" do
      expect(@book2.sequence).to eq(2)
    end

    it "should assign id 3 to the third book" do
      expect(@book3.sequence).to eq(3)
    end

    it "should preserve id 42 on the fourth book" do
      expect(@book4.sequence).to eq(42)
    end

    it "should assign id 1 to the first comment" do
      expect(@comment1.idn).to eq(1)
    end

    it "should assign id 2 to the second comment" do
      expect(@comment2.idn).to eq(2)
    end
  end

  describe "single auto-increment field with seed 1000" do
    it "should assign id 1001 to the first order" do
      expect(@order1.num).to eq(1001)
    end

    it "should assign id 1002 to the second order" do
      expect(@order2.num).to eq(1002)
    end

    it "should assign id 1003 to the third order" do
      expect(@order3.num).to eq(1003)
    end
  end

  describe "two auto-increment fields" do
    it "should assign key 1 to the first post" do
      expect(@post1.key).to eq(501)
    end

    it "should assign key 2 to the second post" do
      expect(@post2.key).to eq(502)
    end

    it "should assign key 3 to the third post" do
      expect(@post3.key).to eq(503)
    end

    it "should assign num 1 to the first post" do
      expect(@post1.num).to eq(1)
    end

    it "should assign num 2 to the second post" do
      expect(@post2.num).to eq(2)
    end

    it "should assign num 3 to the third post" do
      expect(@post3.num).to eq(3)
    end
  end

  describe "auto-increment with step" do
    it "should assign num 1005 to the first invoice" do
      expect(@invoice1.num).to eq(1005)
    end

    it "should assign num 1010 to the second invoice" do
      expect(@invoice2.num).to eq(1010)
    end

    it "should assign num 1015 to the third invoice" do
      expect(@invoice3.num).to eq(1015)
    end
  end

  describe "overwriting _id" do
    it "provides the overwrite option" do
      expect(@author1.fields['_id'].options[:overwrite]).to eq(true)
    end
  end
end
