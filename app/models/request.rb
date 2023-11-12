# == Schema Information
#
# Table name: requests
#
#  id              :bigint           not null, primary key
#  status          :integer          default("pending")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  availability_id :bigint           not null
#  sender_id       :bigint           not null
#
# Indexes
#
#  index_requests_on_availability_id  (availability_id)
#  index_requests_on_sender_id        (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (availability_id => availabilities.id)
#  fk_rails_...  (sender_id => users.id)
#
class Request < ApplicationRecord
  belongs_to :availability
  belongs_to :sender, class_name: 'User'

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :status, presence: true
  validates :availability_id, presence: true
  validates :sender_id, presence: true
  validate :sender_cannot_be_availability_creator

  private

  def sender_cannot_be_availability_creator
    if sender_id == availability.user_id
      errors.add(:sender_id, "cannot request their own availability")
    end
  end
end
