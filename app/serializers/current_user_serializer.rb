class CurrentUserSerializer < UserSerializer
  attributes :admin, :account_id

  def root_name
    'user'
  end
end
