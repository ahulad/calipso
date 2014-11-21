class Incexp < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { maximum: 140 }
  validates :datefinans, presence: true
  validates :categoty_id, presence: true
 # validates :price, presence: true
  validates :price,presence:true, numericality: {only_float: true}
end
