# == Schema Information
#
# Table name: documents
#
#  id                 :integer          not null, primary key
#  FileName           :string(255)
#  Description        :string(255)
#  Contents           :binary
#  Owner              :string(255)
#  AuthorizationLevel :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#

=begin
File represents any image, worksheet, or other large asset uploaded by a 
Registered Teacher or (rarely) Administrator.  These are stored directly in the
database as a blob.  Every file uploaded belongs to the user who uploaded it, in
a one-to-many relationship.

class File connects to the file records in the underlying database through
Rails' ActiveRecord functionality - this hides a lot of the implementation
from us, letting us focus on just what we want to do without dealing with
the database CRUD
=end

# currently, the default ActiveRecord functionality supplied by Rails does
# everything we need.  We may need to revisit in the future, but this will do
# for now
class Document < ActiveRecord::Base
  belongs_to :user, :foreign_key => :id

end
