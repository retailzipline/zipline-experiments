require "application_system_test_case"

class ExperimentsTest < ApplicationSystemTestCase
  setup do
    @experiment = experiments(:one)
  end

  test "visiting the index" do
    visit experiments_url
    assert_selector "h1", text: "Experiments"
  end

  test "should create experiment" do
    visit experiments_url
    click_on "New experiment"

    check "Approved" if @experiment.approved
    fill_in "Created by user", with: @experiment.created_by_user_id
    fill_in "Description", with: @experiment.description
    fill_in "Javascript", with: @experiment.javascript
    fill_in "Key", with: @experiment.key
    fill_in "Stylesheet", with: @experiment.stylesheet
    fill_in "Title", with: @experiment.title
    fill_in "Updated by user", with: @experiment.updated_by_user_id
    click_on "Create Experiment"

    assert_text "Experiment was successfully created"
    click_on "Back"
  end

  test "should update Experiment" do
    visit experiment_url(@experiment)
    click_on "Edit this experiment", match: :first

    check "Approved" if @experiment.approved
    fill_in "Created by user", with: @experiment.created_by_user_id
    fill_in "Description", with: @experiment.description
    fill_in "Javascript", with: @experiment.javascript
    fill_in "Key", with: @experiment.key
    fill_in "Stylesheet", with: @experiment.stylesheet
    fill_in "Title", with: @experiment.title
    fill_in "Updated by user", with: @experiment.updated_by_user_id
    click_on "Update Experiment"

    assert_text "Experiment was successfully updated"
    click_on "Back"
  end

  test "should destroy Experiment" do
    visit experiment_url(@experiment)
    click_on "Destroy this experiment", match: :first

    assert_text "Experiment was successfully destroyed"
  end
end
