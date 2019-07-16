FactoryBot.define do
  factory :user do
    first_name { 'Pepe' }
    last_name { 'Bas' }
    username { 'Asshole' }
    email { 'pepe.bas@example.com' }
    gender { 'male' }
    birthday { '05-05-1999' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
