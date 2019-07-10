class Like < ApplicationRecord
  belongs_to :post, class_name: 'Like', foreign_key: :object_id
  belongs_to :comment, class_name: 'Like', foreign_key: :object_id
  belongs_to :user
end
