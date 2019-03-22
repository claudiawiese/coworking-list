desc 'confirmation_three_months'
task confirmation_three_months: :environment do
  # ... set options if any
  ClientMailer.confirmation_three_months_update(options).deliver!
end
