require 'rails_helper'
feature 'Post' do
  scenario "adds a new post" do
    user = create(:user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit root_path
    expect{
      fill_in 'Create Post', with: 'Welcome user'
      click_button 'Create Post'
    }.to change(Post, :count).by(1)
    expect(current_path).to eq posts_path
    expect(page).to have_content 'Welcome user'
  end

  scenario "add a comment" do
    user = create(:user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit root_path
    expect{
      fill_in 'Create Post', with: 'Welcome user'
      click_button 'Create Post'
      visit root_path
      fill_in 'Create Comment', with: 'Nice photo'
      click_button 'Comment'
    }.to change(Comment, :count).by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Nice photo'
  end
end
