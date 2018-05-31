class AreaSeeder
  def initialize(data=[])
    @data = data
  end

  def run
    @data.each do |country_hash|
      country = Area.create!(name: country_hash[:name])

      country_hash[:children].each do |region_hash|
        region = country.children.create!(name: region_hash[:name])

        region_hash[:children].each do |metro_hash|
          metro_area = region.children.create!(name: metro_hash[:name])
          
        end
      end
    end
  end
end