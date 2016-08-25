class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :restaurant
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "You have reviewed this restaurant already" }

  def build_review

  end

end
