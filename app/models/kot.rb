class Kot < ApplicationRecord
  # belongs_to :user, dependent: :destroy
  has_many_attached :photos
end
