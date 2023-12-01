module ControllerMacros
  def login_user
    user = create(:user)
    allow(controller).to receive(:current_user).and_return(user)
  end
  def include_api_key
    allow(controller).to receive(:find_api_key).and_return(true)
  end
end