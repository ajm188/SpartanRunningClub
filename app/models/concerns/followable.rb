module Followable
  extend ActiveSupport::Concern

  included do
    has_many :followings, as: :followable
    has_many :members, through: :followings
  end
end