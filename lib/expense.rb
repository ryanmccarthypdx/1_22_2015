class Expense
  attr_reader(:id, :business_id, :name, :amount, :date)


  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @business_id = attributes.fetch(:business_id)
    @name = attributes.fetch(:name)
    @amount = attributes.fetch(:amount)
    @date = attributes.fetch(:date)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (name, amount, date, business_id) VALUES ('#{@name}', #{@amount}, '#{@date}', #{@business_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_expenses = DB.exec("SELECT * FROM expenses;")
    expenses = []
    returned_expenses.each() do |expense|
      id = expense.fetch("id").to_i()
      business_id = expense.fetch("business_id").to_i()
      name = expense.fetch("name")
      amount = expense.fetch("amount").to_f()
      date = expense.fetch("date")
      expenses.push(Expense.new({ :name => name, :id => id, :business_id => business_id, :date => date, :amount => amount }))
    end
    expenses
  end

  define_method(:==) do |another_expense|
    self.name().==(another_expense.name()).&(self.id().==(another_expense.id()))
  end

  define_singleton_method(:find) do |find_id|
    expense_result = DB.exec("SELECT * FROM expenses WHERE id = #{find_id};")
    expense = expense_result.first()
    id = expense.fetch("id").to_i()
    business_id = expense.fetch("business_id").to_i()
    name = expense.fetch("name")
    amount = expense.fetch("amount").to_f()
    date = expense.fetch("date")
    Expense.new({ :name => name, :id => id, :business_id => business_id, :date => date, :amount => amount })
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM expenses *;")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM expenses * WHERE id = #{@id};") #asterisk is not necessary if we trust (id serial)
  end

  define_method(:update) do |attr_hash|
    @id = self.id()
    @name = attr_hash.fetch(:name)
    @amount = attr_hash.fetch(:amount)
    @date = attr_hash.fetch(:date)
    @business_id = attr_hash.fetch(:business_id)
    DB.exec("UPDATE expenses SET (name, amount, date, business_id) = ('#{@name}', #{@amount}, '#{@date}', #{@business_id}) WHERE id = #{@id};")
    ####this is awesome as well.  SET (x, y, z) = (x, y, z)
  end

  




end
