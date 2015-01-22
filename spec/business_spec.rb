require('spec_helper')

describe(Business) do

  describe('.all') do
    it('takes a list of businesses and returns all') do
      test_business1 = Business.new({:id => nil, :name => "Fred Meyer"})
      test_business1.save()
      test_business2 = Business.new({:id => nil, :name => "Walmart"})
      test_business2.save()
      expect(Business.all()).to(eq([test_business1, test_business2]))
    end
  end

  describe('.find') do
    it('returns an object from an id input') do
      test_business1 = Business.new({:id => nil, :name => "Fred Meyer"})
      test_business1.save()
      test_business2 = Business.new({:id => nil, :name => "Walmart"})
      test_business2.save()
      tb1i = test_business1.id()
      expect(Business.find(tb1i)).to(eq(test_business1))
    end
  end

  describe('.clear') do
    it('clears all businesses from the database') do
      test_business1 = Business.new({:id => nil, :name => "Fred Meyer"})
      test_business1.save()
      test_business2 = Business.new({:id => nil, :name => "Walmart"})
      test_business2.save()
      Business.clear()
      expect(Business.all()).to(eq([]))
    end
  end

  describe('#delete') do
    it('deletes a single business from the database') do
      test_business1 = Business.new({:id => nil, :name => "Fred Meyer"})
      test_business1.save()
      test_business2 = Business.new({:id => nil, :name => "Walmart"})
      test_business2.save()
      test_business1.delete()
      expect(Business.all()).to(eq([test_business2]))
    end
  end

  describe('#update') do
    it('changes a given value of an business') do
      test_business = Business.new({:id => nil, :name => "Fred Meyer"})
      test_business.save()
      tid = test_business.id()
      mod_hash = { :name => "Walmart"}
      test_business.update(mod_hash)
      expect(Business.find(tid).name()).to(eq("Walmart"))
    end
  end



end
