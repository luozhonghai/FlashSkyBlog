class Message < ActiveRecord::Base
  default_scope order: 'id desc'
  belongs_to :user
end
