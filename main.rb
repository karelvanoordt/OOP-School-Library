require './person'
require './teacher'
require './student'
require './classroom'
require './book'
require './rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App'
    loop do
      menu
      option = gets.chomp
      break if option == '7'

      get_num option
    end
    puts 'Thank you for using our Library!'
  end

  def menu
    puts 'Please choose an option by entering a number'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person ID'
    puts '7 - Exit app'
  end

  def get_num(option)
    case option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_rentals_p_id
    else
      puts 'Please enter a number between 1 and 7'
    end
  end

  def list_all_books
    puts 'There are no books listed yet' if @books.empty?

    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    sleep 1.2
  end

  def list_all_people
    puts 'There are no people listed yet' if @people.empty?

    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    sleep 1.2
  end

  def create_person
    print 'Enter (1) to create a student and (2) to create a teacher: '
    option = gets.chomp

    case option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Input invalid. Please enter (1) to create a student and (2) to create a teacher: '
    end
  end

  def create_student
    print 'Name: '
    name = gets.chomp.capitalize

    print 'Age: '
    age = gets.chomp.to_i

    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase

    student = Student.new(parent_permission, age, name)
    @people << student

    puts 'Student created'
    sleep 1.2
  end

  def create_teacher
    print 'Name: '
    name = gets.chomp.capitalize

    print 'Age: '
    age = gets.chomp.to_i

    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @people << teacher

    puts 'Teacher created'
    sleep 1.2
  end

  def create_book
    print 'Book Title: '
    title = gets.chomp.capitalize

    print 'Author: '
    author = gets.chomp.capitalize

    book = Book.new(title, author)
    @books << book

    puts 'Book added'
    sleep 1.2
  end
end

def create_rental
  puts 'Select one of the books of the list below: '
  @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }

  book_id = gets.chomp.to_i

  puts 'Select a person number (not id) from the list below'
  @people.each_with_index do |person, index|
    puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end

  person_id = gets.chomp.to_i

  print 'Date: '
  date = gets.chomp.to_s

  rental = Rental.new(date, @people[person_id], @books[book_id])
  @rentals << rental

  puts 'Rental created'
  sleep 1.2
end

def list_rentals_p_id
  print 'Enter person ID: '
  id = gets.chomp.to_i

  puts 'Rentals: '
  @rentals.each do |rental|
    puts "Date: #{rental.date}, Book: #{rental.book.title} - #{rental.book.author}" if rental.person.id == id
  end
  sleep 1.2
end

def main
  app = App.new
  app.run
end

main
