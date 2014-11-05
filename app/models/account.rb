class Account < ActiveRecord::Base
  has_many :charges
end
