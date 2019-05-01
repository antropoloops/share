# frozen_string_literal: true

namespace :populate do
  task load: :environment do
    description = 'Collaborative music piece Istanbul / Warsaw / Seville'
    space = Space.find_by(name: 'Iswase')
    space&.destroy
    space = Space.create!(name: 'Iswase', description: description)
    %w[danigb rubenxito espeee].each do |name|
      email = "#{name}@gmail.com"
      user = User.find_by(email: email)
      user ||= User.create!(email: email,
                            name: name,
                            password: 'secret',
                            password_confirmation: 'secret')
      Membership.create(user: user, space: space, level: 'admin')
    end
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
