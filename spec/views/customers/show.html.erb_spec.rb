# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'customers/show', type: :view do
  before(:each) do
    @customer = FactoryBot.create(:customer)
    assign(:customer, @customer)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/22222/)
    expect(rendered).to match(/Test customer/)
    expect(rendered).to match(/www.test.com/)
    expect(rendered).to match(/test@test.com/)
    expect(rendered).to match(/033333333/)
    expect(rendered).to match(/34 Block/)
    expect(rendered).to match(/Pakistan/)
    expect(rendered).to match(/Punjab/)
    expect(rendered).to match(/Lahore/)
    expect(rendered).to match(/54000/)
    expect(rendered).to match(/active/)
    expect(rendered).to match(/Softwore/)
  end
end
