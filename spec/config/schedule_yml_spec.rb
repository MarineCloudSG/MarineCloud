require 'rails_helper'

RSpec.describe 'config/schedule.yml', type: :yaml do
  it 'exists' do
    expect(File).to exist('config/schedule.yml')
  end

  it 'schedules last month data import reminders on days 1 and 3 of each month, at 12:00 AM' do
    expect(yaml).to schedule_service(SendDataImportReminders).at('At 12:00 AM, on day 1 and 3 of the month')
  end
end
