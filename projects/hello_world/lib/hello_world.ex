defmodule HelloWorld do
  def hello do
    "Hello, #{Faker.Person.first_name()}."
  end
end
