# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
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
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Profile Picture Url/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
