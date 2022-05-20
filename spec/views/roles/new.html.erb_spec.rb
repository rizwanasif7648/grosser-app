# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'roles/new', type: :view do
  before(:each) do
    assign(:role, Role.new(
                    title: 'MyString',
                    status: 1,
                    created_by: 1,
                    updated_by: 1
                  ))
  end

  it 'renders new role form' do
    render

    assert_select 'form[action=?][method=?]', roles_path, 'post' do
      assert_select 'input[name=?]', 'role[title]'

      assert_select 'input[name=?]', 'role[status]'

      assert_select 'input[name=?]', 'role[created_by]'

      assert_select 'input[name=?]', 'role[updated_by]'
    end
  end
end
