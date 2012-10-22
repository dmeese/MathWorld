class User
  attr_accessor :UserIndex, :UserId, :Password, :AuthorizationLevel, :FailedAttempts, :Email

  def initialize(attribute = {})
    @UserIndex = attributes[:UserIndex]
    @UserId = attributes[:UserId]
    @Password = attributes[:Password]
    @AuthorizationLevel = attributes[:AuthorizationLevel]
    @FailedAttempts = attributes[:FailedAttempts]
    @Email = attributes[:Email]
  end
end