class GroupUser < ApplicationRecord
  has_one_attached :groups
  has_one_attached :users
end
