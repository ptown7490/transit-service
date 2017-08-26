class Seed

  def self.begin
    seed = Seed.new
    seed.generate_agencies
  end

  def generate_agencies
    Agency.create!(name: 'TriMet')
  end

end

Seed.begin
