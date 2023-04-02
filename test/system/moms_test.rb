require "application_system_test_case"

class MomsTest < ApplicationSystemTestCase
  setup do
    @mom = moms(:one)
  end

  test "visiting the index" do
    visit moms_url
    assert_selector "h1", text: "Moms"
  end

  test "should create mom" do
    visit moms_url
    click_on "New mom"

    fill_in "Attendby", with: @mom.attendby
    fill_in "Callby", with: @mom.callby_id
    fill_in "Calledby", with: @mom.calledby
    fill_in "Date", with: @mom.date
    fill_in "Descrption", with: @mom.descrption
    fill_in "Meet", with: @mom.meet_id
    fill_in "Report", with: @mom.report
    fill_in "Title", with: @mom.title
    fill_in "Venue", with: @mom.venue
    click_on "Create Mom"

    assert_text "Mom was successfully created"
    click_on "Back"
  end

  test "should update Mom" do
    visit mom_url(@mom)
    click_on "Edit this mom", match: :first

    fill_in "Attendby", with: @mom.attendby
    fill_in "Callby", with: @mom.callby_id
    fill_in "Calledby", with: @mom.calledby
    fill_in "Date", with: @mom.date
    fill_in "Descrption", with: @mom.descrption
    fill_in "Meet", with: @mom.meet_id
    fill_in "Report", with: @mom.report
    fill_in "Title", with: @mom.title
    fill_in "Venue", with: @mom.venue
    click_on "Update Mom"

    assert_text "Mom was successfully updated"
    click_on "Back"
  end

  test "should destroy Mom" do
    visit mom_url(@mom)
    click_on "Destroy this mom", match: :first

    assert_text "Mom was successfully destroyed"
  end
end
