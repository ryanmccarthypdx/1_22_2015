require('spec_helper')

describe(Expense) do
  describe('.all') do
    it('returns all of the expenses ever') do
      test_expense1 = Expense.new({ :id => nil, :name => "condoms", :amount => 6.99, :date => "2015-01-22",:business_id => 1})
      test_expense1.save()
      test_expense2 = Expense.new({ :id => nil, :name => "nyquil", :amount => 8.99, :date => "2015-01-22",:business_id => 1})
      test_expense2.save()
      expect(Expense.all()).to(eq([test_expense1, test_expense2]))
    end
  end

  describe('.find') do
    it('returns an object from an id input') do
      test_expense1 = Expense.new({ :id => nil, :name => "condoms", :amount => 6.99, :date => "2015-01-22",:business_id => 1})
      test_expense1.save()
      test_expense2 = Expense.new({ :id => nil, :name => "nyquil", :amount => 8.99, :date => "2015-01-22",:business_id => 1})
      test_expense2.save()
      te1i = test_expense1.id()
      expect(Expense.find(te1i)).to(eq(test_expense1))
    end
  end

  describe('.clear') do
    it('clears all expenses from the database') do
      test_expense1 = Expense.new({ :id => nil, :name => "condoms", :amount => 6.99, :date => "2015-01-22",:business_id => 1})
      test_expense1.save()
      test_expense2 = Expense.new({ :id => nil, :name => "nyquil", :amount => 8.99, :date => "2015-01-22",:business_id => 1})
      test_expense2.save()
      Expense.clear()
      expect(Expense.all()).to(eq([]))
    end
  end

  describe('#delete') do
    it('deletes a single expense from the database') do
      test_expense1 = Expense.new({ :id => nil, :name => "condoms", :amount => 6.99, :date => "2015-01-22",:business_id => 1})
      test_expense1.save()
      test_expense2 = Expense.new({ :id => nil, :name => "nyquil", :amount => 8.99, :date => "2015-01-22",:business_id => 1})
      test_expense2.save()
      test_expense1.delete()
      expect(Expense.all()).to(eq([test_expense2]))
    end
  end

  describe('#update') do
     it('changes a given value of an expense') do
       test_expense = Expense.new({ :id => nil, :name => "condoms", :amount => 6.99, :date => "2015-01-22",:business_id => 1})
       test_expense.save()
       tid = test_expense.id()
       mod_hash = { :name => "condoms", :amount => 7.99, :date => "2015-01-22",:business_id => 2}
       test_expense.update(mod_hash)
       expect(Expense.find(tid).amount()).to(eq(7.99))
       expect(Expense.find(tid).business_id()).to(eq(2))  #this is awesome: you can do multiple expects, no problem
     end
   end

   describe('#categorize') do
     it('takes an expense and categorizes it') do
       test_expense = Expense.new({ :id => nil, :name => "condoms", :amount => 6.99, :date => "2015-01-22",:business_id => 1})
       test_category1 = Category.new({:id => nil, :name => "Pleasure"})
       test_category2 = Category.new({:id => nil, :name => "Business"})
       test_category.save()
       test_expense.save()
       test_expense_id = test_expense.id()
       tc1i = test_category1.id()
       tc2i = test_category2.id()
       test_expenses.categorize([tc1i, tc2i])
       #expect(Expense.regurgitate(test_expense_id)).to(eq([test_category1, test_category2]))
       all_spendings = Spendings.all()
       output = []
       all_spendings.each() do |spending|
         output.push(spending.category_id())
       end
       expect(output).to(eq[tc1i, tc2i])
     end
   end
