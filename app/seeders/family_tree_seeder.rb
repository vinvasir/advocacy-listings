class FamilyTreeSeeder
  def initialize(data=[])
    @data = data
  end

  def run
    @data.each do |root_hash|
      root = klass.create!(name: root_hash[:name])

      root_hash[:children].each do |inter_hash|
        inter = root.children.create!(name: inter_hash[:name])

        inter_hash[:children].each do |child_hash|
          child = inter.children.create!(name: child_hash[:name])
        end
      end
    end
  end
end