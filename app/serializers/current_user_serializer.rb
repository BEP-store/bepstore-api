class CurrentUserSerializer < UserSerializer
  attributes :admin, :account_id

  has_one :account do
    { type: 'accounts', id: object.account_id } if object.account_id.present?
  end
end
