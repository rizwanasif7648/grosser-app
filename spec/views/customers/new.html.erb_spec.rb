# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'customers/new', type: :view do
  before(:each) do
    @customer = FactoryBot.create(:customer)
    assign(:customer, @customer)
  end

  it 'renders new customer form' do
    render

    assert_select 'form[action=?][method=?]', customers_path, 'post' do
      assert_select 'input[name=?]', 'customer[name]'

      assert_select 'input[name=?]', 'customer[url]'

      assert_select 'input[name=?]', 'customer[email]'

      assert_select 'input[name=?]', 'customer[phone]'

      assert_select 'input[name=?]', 'customer[street_address]'

      assert_select 'input[name=?]', 'customer[country]'

      assert_select 'input[name=?]', 'customer[state]'

      assert_select 'input[name=?]', 'customer[city]'

      assert_select 'input[name=?]', 'customer[postcode]'

      assert_select 'input[name=?]', 'customer[status]'

      assert_select 'input[name=?]', 'customer[industry]'
    end
  end
end
