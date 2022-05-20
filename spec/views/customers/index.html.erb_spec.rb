# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'customers/index', type: :view do
  before(:each) do
    @customer = FactoryBot.create(:customer)
    assign(:customers, [@customer])
  end

  it 'renders a list of customers' do
    render
    assert_select 'tr>td', text: '22222'.to_s, count: 1
    assert_select 'tr>td', text: 'Test customer'.to_s, count: 1
    assert_select 'tr>td', text: 'www.test.com'.to_s, count: 1
    assert_select 'tr>td', text: 'test@test.com'.to_s, count: 1
    assert_select 'tr>td', text: '033333333'.to_s, count: 1
    assert_select 'tr>td', text: '34 Block'.to_s, count: 1
    assert_select 'tr>td', text: 'Pakistan'.to_s, count: 1
    assert_select 'tr>td', text: 'Punjab'.to_s, count: 1
    assert_select 'tr>td', text: 'Lahore'.to_s, count: 1
    assert_select 'tr>td', text: '54000'.to_s, count: 1
    assert_select 'tr>td', text: 'active'.to_s, count: 1
    assert_select 'tr>td', text: 'Softwore'.to_s, count: 1
  end
end
