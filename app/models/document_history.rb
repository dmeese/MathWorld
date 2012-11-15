# == Schema Information
#
# Table name: document_histories
#
#  id            :integer          not null, primary key
#  document_id   :integer
#  document_name :string(255)
#  user_id       :integer
#  user_name     :string(255)
#  change_type   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DocumentHistory < ActiveRecord::Base
  attr_accessible :change_type, :document_name, :document_id, :user_id, :user_name
end
