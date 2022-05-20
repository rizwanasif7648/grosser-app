# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boxes/index', type: :view do
  before(:each) do
    @box = FactoryBot.create(:box)
    assign(:boxs, [@box])
  end

  it 'renders a list of boxes' do
    render
    assert_select 'tr>td', text: '2222'.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 'E3'.to_s, count: 2
    assert_select 'tr>td', text: 'typet'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 1
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
  end
end
