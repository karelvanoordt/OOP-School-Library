require './person.rb'

class Teacher < Person
  def initialize(age, specialization, name = 'Unknown')
    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
