class Kot < ApplicationRecord
  # belongs_to :user, dependent: :destroy
  has_many_attached :photos
  geocoded_by :addresse
  after_validation :geocode, if: :will_save_change_to_addresse?
end
