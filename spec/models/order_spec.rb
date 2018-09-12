require 'rails_helper'

describe Order, type: :model do
  describe 'validations' do
    it {should validate_presence_of :status}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
    it {should validate_presence_of :user_id}
  end

  describe 'relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
  end
end
