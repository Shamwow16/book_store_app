class Publisher < ActiveRecord::Base
  has_many :books
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  belongs_to :author
  belongs_to :book

  has_many :publications
end
