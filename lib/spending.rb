

class Spending
  attr_reader(:id, :expenses_id, :categories_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @categories_id = attributes.fetch(:categories_id)
    @expenses_id = attributes.fetch(:expenses_id)
  end

  define_singleton_method(:all) do
    returned_spendings = DB.exec("SELECT * FROM spendings;")
    spendings = []
    returned_spendings.each() do |spending|
      @categories_id = spending.fetch("categories_id").to_i()
      @expenses_id = spending.fetch("expenses_id").to_i()
      @id = spending.fetch("id").to_i()
      spendings.push(Spending.new({:id => @id, :categories_id => @categories_id, :expenses_id => @expenses_id}))
    end
    spendings
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO spendings (categories_id, expenses_id) VALUES (#{@categories_id}, #{@expenses_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_spendings|
    self.expenses_id().==(another_spendings.expenses_id()).&(self.id().==(another_spendings.id()))
  end


end
