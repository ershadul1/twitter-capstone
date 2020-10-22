describe 'Following Process', type: :feature do
    before :each do
      @user = User.create(name: 'enzolonghi6', email: 'enzojaja@gmail123.com', password: '123456', password_confirmation: '123456')
      @user2 = User.create(name: 'cocolonghi6', email: 'cocojaja@gmail123.com', password: '123456', password_confirmation: '123456')
    end
  
    it 'Follow a user' do
      visit '/users/sign_in'
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'

      visit user_path(@user2)
      click_link 'Follow'
      expect(page).to have_content 'Unfollow'
    end

  end