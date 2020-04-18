class Kot < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  geocoded_by :addresse
  after_validation :geocode, if: :will_save_change_to_addresse?
  validates :addresse, presence: true
  # validates :type, presence: true
  validates :quartier, presence: true
  # validates :nombre_chambres, presence: true
end
