module Concerns::Findable
  def find_by_name(name)
    output = nil
    self.all.each do |item|
      if item.name == name
        output = item
      end
    end
    output
  end

  def find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end
end
