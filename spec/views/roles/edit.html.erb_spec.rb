# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'roles/edit', type: :view do
  before(:each) do
    @role = assign(:role, Role.create!(
                            title: 'MyString',
                            status: 1,
                            created_by: 1,
                            updated_by: 1
                          ))
  end

  it 'renders the edit role form' do
    render

    assert_select 'form[action=?][method=?]', role_path(@role), 'post' do
      assert_select 'input[name=?]', 'role[title]'

      assert_select 'input[name=?]', 'role[status]'

      assert_select 'input[name=?]', 'role[created_by]'

      assert_select 'input[name=?]', 'role[updated_by]'
    end
  end
end
