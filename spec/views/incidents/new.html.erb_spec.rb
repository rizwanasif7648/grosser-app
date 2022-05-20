# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'incidents/new', type: :view do
  before(:each) do
    @incident = FactoryBot.create(:incident)
    assign(:incident, @incident)
  end

  it 'renders new incident form' do
    render

    assert_select 'form[action=?][method=?]', incidents_path, 'post' do
      assert_select 'input[name=?]', 'incident[customer_id]'

      assert_select 'input[name=?]', 'incident[user_id]'

      assert_select 'input[name=?]', 'incident[incident_id]'

      assert_select 'input[name=?]', 'incident[status]'

      assert_select 'input[name=?]', 'incident[created_by_id]'

      assert_select 'input[name=?]', 'incident[updateed_by_id]'
    end
  end
end
