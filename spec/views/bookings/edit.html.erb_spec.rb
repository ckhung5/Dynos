require 'rails_helper'

RSpec.describe "bookings/edit", type: :view do
  before(:each) do
    @booking = assign(:booking, Booking.create!(
      :event => nil,
      :user => nil
    ))
  end

  it "renders the edit booking form" do
    render

    assert_select "form[action=?][method=?]", booking_path(@booking), "post" do

      assert_select "input#booking_event_id[name=?]", "booking[event_id]"

      assert_select "input#booking_user_id[name=?]", "booking[user_id]"
    end
  end
end
