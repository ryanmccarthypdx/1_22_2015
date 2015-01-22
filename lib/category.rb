
class Category

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_categories = DB.exec("SELECT * FROM categories;")
    categories = []
    returned_categories.each() do |category|
      id = category.fetch("id").to_i()
      name = category.fetch("name")
      categories.push(Category.new({:id => id, :name => name}))
    end
    categories
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO categories (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_category|
    self.name().==(another_category.name()).&(self.id().==(another_category.id()))
  end

  define_singleton_method(:find) do |find_id|
    category_result = DB.exec("SELECT * FROM categories WHERE id = #{find_id};")
    category = category_result.first()
    id = category.fetch("id").to_i()
    name = category.fetch("name")
    Category.new({ :name => name, :id => id})
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM categories *;")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM categories * WHERE id = #{@id};") #asterisk is not necessary if we trust (id serial)
  end

  define_method(:update) do |attr_hash|
    @id = self.id()
    @name = attr_hash.fetch(:name)
    DB.exec("UPDATE categories SET (name) = ('#{@name}') WHERE id = #{@id};")
    ####this is awesome as well.  SET (x, y, z) = (x, y, z)
  end


end
