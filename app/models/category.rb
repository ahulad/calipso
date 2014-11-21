class Category < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { maximum: 140 }
end
