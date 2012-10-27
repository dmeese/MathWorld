# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  SessionID  :string(255)
#  UserIndex  :integer
#  LastUpdate :datetime
#

class Session < ActiveRecord::Base
  # attr_accessible :title, :body
end
