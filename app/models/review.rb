class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :restaurant
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "You have reviewed this restaurant already" }

  # def build_review(review_params, user)
  #   review = reviews.build(review_params)
  #   review.user = user
  #   review
  # end



end
