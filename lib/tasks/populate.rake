# frozen_string_literal: true

namespace :populate do
  task load: :environment do
  end

  task fake_data: %i(users spaces)

  task users: :environment do
    100.times do
      FactoryBot.create(:user,
                        name: Faker::Name.first_name)
    end
  end

  task spaces: :environment do
    100.times do
      FactoryBot.create(:space, name: Faker::Company.name)
    end
  end
end
