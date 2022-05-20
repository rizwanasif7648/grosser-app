# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [
             User.create!(
               email: 'Email',
               password: 'Password',
               name: 'Name',
               phone: 'Phone',
               profile_picture_url: 'Profile Picture Url',
               status: 2,
               is_web_user: false,
               is_superuser: false,
               created_by: 3,
               updated_by: 4
             ),
             User.create!(
               email: 'Email',
               password: 'Password',
               name: 'Name',
               phone: 'Phone',
               profile_picture_url: 'Profile Picture Url',
               status: 2,
               is_web_user: false,
               is_superuser: false,
               created_by: 3,
               updated_by: 4
             )
           ])
  end

  it 'renders a list of users' do
    render
    assert_select 'tr>td', text: 'Email'.to_s, count: 2
    assert_select 'tr>td', text: 'Password'.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Phone'.to_s, count: 2
    assert_select 'tr>td', text: 'Profile Picture Url'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 4.to_s, count: 2
  end
end
