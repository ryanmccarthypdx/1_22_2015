require('spec_helper')

describe(Spending) do

  describe('.all') do
    it('takes a list of spending and returns all') do
      test_spending1 = Spending.new({:id => nil, :expense_id => 1, :categories => 1})
      test_spending1.save()
      test_spending2 = Spending.new({:id => nil, :expense_id => 2, :categories => 2})
      test_spending2.save()
      expect(Spending.all()).to(eq([test_spending1, test_spending2]))
    end
  end

end
