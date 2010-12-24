require 'reversible_data'

ReversibleData.in_memory!

ReversibleData.add :publishable do |p|
  p.datetime :published_at
end

ReversibleData.add :simple_convertable do |sc|
  sc.text :description
  sc.text :rendered_description
end

ReversibleData.add :simple_convertable_with_format do |sc|
  sc.text   :description
  sc.text   :rendered_description
  sc.string :format
end

ReversibleData.add :multiple_convertable do |mc|
  mc.text :description
  mc.text :rendered_description
  mc.text :profile
  mc.text :rendered_profile
end