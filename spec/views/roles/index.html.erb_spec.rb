# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'roles/index', type: :view do
  before(:each) do
    assign(:roles, [
             Role.create!(
               title: 'Title',
               status: 2,
               created_by: 3,
               updated_by: 4
             ),
             Role.create!(
               title: 'Title',
               status: 2,
               created_by: 3,
               updated_by: 4
             )
           ])
  end

  it 'renders a list of roles' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 4.to_s, count: 2
  end
end
