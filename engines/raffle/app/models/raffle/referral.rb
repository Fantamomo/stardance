module Raffle
  # A new platform user attributed to a participant's referral link. Starts
  # `pending`; converts to `verified` (+tickets) when the referred user clears
  # the platform's ID verification. `self_referral` is hidden and uncredited.
  class Referral < ApplicationRecord
    has_paper_trail

    belongs_to :participant, class_name: "Raffle::Participant"
    belongs_to :referred_user, class_name: "::User"
    belongs_to :credited_week, class_name: "Raffle::Week", optional: true

    enum :channel, { web: "web", discord: "discord" }, prefix: :channel
    enum :status, { pending: "pending", verified: "verified", self_referral: "self_referral", rejected: "rejected" },
         prefix: :status

    validates :channel, :status, presence: true
    validates :referred_user_id, uniqueness: true
    validates :tickets_awarded, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
