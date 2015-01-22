
class Business

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_businesses = DB.exec("SELECT * FROM businesses;")
    businesses = []
    returned_businesses.each() do |business|
      id = business.fetch("id").to_i()
      name = business.fetch("name")
      businesses.push(Business.new({:id => id, :name => name}))
    end
    businesses
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO businesses (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_business|
    self.name().==(another_business.name()).&(self.id().==(another_business.id()))
  end

  define_singleton_method(:find) do |find_id|
    business_result = DB.exec("SELECT * FROM businesses WHERE id = #{find_id};")
    business = business_result.first()
    id = business.fetch("id").to_i()
    name = business.fetch("name")
    Business.new({ :name => name, :id => id})
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM businesses *;")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM businesses * WHERE id = #{@id};") #asterisk is not necessary if we trust (id serial)
  end

  define_method(:update) do |attr_hash|
    @id = self.id()
    @name = attr_hash.fetch(:name)
    DB.exec("UPDATE businesses SET (name) = ('#{@name}') WHERE id = #{@id};")
    ####this is awesome as well.  SET (x, y, z) = (x, y, z)
  end


end
