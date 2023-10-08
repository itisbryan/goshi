# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  first_name         :string           not null
#  last_name          :string           not null
#  login              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
