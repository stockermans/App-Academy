# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class CatRentalRequest < ApplicationRecord
  include ActionView::Helpers::DateHelper

  def self.statuses
    %w(PENDING APPROVED DENIED)
  end

  validates :user_id, presence: true
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: self.statuses, message: "%{value} is not a valid status" }
  validate :does_not_overlap_approved_request, unless: -> { status == "DENIED" }

  belongs_to(:cat, {
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat
  })

  belongs_to(:renter, {
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  })

  def overlapping_requests
    CatRentalRequest
      .where.not('start_date > :ending_date OR end_date < :starting_date', starting_date: self.start_date, ending_date: self.end_date)
      .where.not(id: id)
      .where(cat_id: cat_id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def does_not_overlap_approved_request
    if overlapping_requests.exists?
      errors[:base] << "has an overlap with an approved rental request"
      false
    else
      true
    end
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_pending_requests.each do |pending_request|
        pending_request.status = "DENIED"
        pending_request.save!
      end
    end
  end

  def deny!
    self.update({status: "DENIED"})
  end
end
