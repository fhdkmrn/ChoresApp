# frozen_string_literal: true

class User < ActiveRecord::Base
  serialize :approvalLists, Array
  serialize :tradeRequests, Array
  serialize :declinedTrade, Array
  has_attached_file :photo,
                    url: '/assets/user/:id/:style/:basename.:extension',
                    path: ':rails_root/public/assets/user/:id/:style/:basename.:extension'

  validates_attachment_presence :photo
  validates_attachment_content_type :photo, content_type: %w[image/jpg image/jpeg image/png image/gif]
  has_secure_password
  validates :email, email_format: { message: "doesn't look like an email address" },
                    presence: true,
                    uniqueness: true
  validates :name, uniqueness: true,
                   presence: true
  validates :phone, presence: true,
                    numericality: true,
                    length: { minimum: 10, maximum: 10 }
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
