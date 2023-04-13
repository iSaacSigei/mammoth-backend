class Land < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  mount_uploader :image, ImageUploader  
end
