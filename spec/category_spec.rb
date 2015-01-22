require('spec_helper')

describe(Category) do

  describe('.all') do
    it('takes a list of categories and returns all') do
      test_category1 = Category.new({:id => nil, :name => "Food"})
      test_category1.save()
      test_category2 = Category.new({:id => nil, :name => "Entertainment"})
      test_category2.save()
      expect(Category.all()).to(eq([test_category1, test_category2]))
    end
  end

  describe('.find') do
    it('returns an object from an id input') do
      test_category1 = Category.new({:id => nil, :name => "Food"})
      test_category1.save()
      test_category2 = Category.new({:id => nil, :name => "Entertainment"})
      test_category2.save()
      tc1i = test_category1.id()
      expect(Category.find(tc1i)).to(eq(test_category1))
    end
  end

  describe('.clear') do
    it('clears all categories from the database') do
      test_category1 = Category.new({:id => nil, :name => "Food"})
      test_category1.save()
      test_category2 = Category.new({:id => nil, :name => "Entertainment"})
      test_category2.save()
      Category.clear()
      expect(Category.all()).to(eq([]))
    end
  end

  describe('#delete') do
    it('deletes a single category from the database') do
      test_category1 = Category.new({:id => nil, :name => "Food"})
      test_category1.save()
      test_category2 = Category.new({:id => nil, :name => "Entertainment"})
      test_category2.save()
      test_category1.delete()
      expect(Category.all()).to(eq([test_category2]))
    end
  end

  describe('#update') do
    it('changes a given value of an category') do
      test_category = Category.new({:id => nil, :name => "Food"})
      test_category.save()
      tid = test_category.id()
      mod_hash = { :name => "Entertainment"}
      test_category.update(mod_hash)
      expect(Category.find(tid).name()).to(eq("Entertainment"))
    end
  end



end
