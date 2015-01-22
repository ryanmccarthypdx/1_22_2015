class Spending

  attr_reader(:business_id, :expense_id, :id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @business_id = attributes.fetch(:business_id)
    @expense_id = attributes.fetch(:expense_id)
  end

  define_singleton_method(:all) do
    returned_spendings = DB.exec("SELECT * FROM spendings;")
    spendings = []
    returned_spendings.each() do |spending|
      @business_id = spending.fetch("business_id").to_i()
      @expense_id = spending.fetch("expense_id").to_i()
      spendings.push(Spending.new({:business_id => @business_id, :expense_id => @expense_id}))
    end
    spendings
  end

end
