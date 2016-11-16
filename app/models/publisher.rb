class Publisher < ActiveRecord::Base
  has_many :books
  has_many :publications
  belongs_to :author
  belongs_to :book

  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}




end
