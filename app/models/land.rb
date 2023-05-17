class Land < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true

  before_validation :generate_parcel_id, on: :create
  def generate_parcel_id
    loop do
      self.parcel_id = "MAM#{SecureRandom.alphanumeric(3).upcase}#{SecureRandom.random_number(1000)}"
      break unless Land.exists?(parcel_id: parcel_id)
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
