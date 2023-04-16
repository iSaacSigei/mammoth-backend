class Land < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  mount_uploader :image, ImageUploader  
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  
  before_validation :generate_parcel_id, on: :create
  
  def generate_parcel_id
    puts "Starting generate_parcel_id..."
    loop do
      self.parcel_id = "JPG#{SecureRandom.alphanumeric(6).upcase}#{SecureRandom.random_number(100000)}"
      puts "Generated parcel_id: #{parcel_id}"
      break unless Land.exists?(parcel_id: parcel_id)
    end
    puts "Ending generate_parcel_id..."
    self.parcel_id # return the generated parcel_id
  end  
end
