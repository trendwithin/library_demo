# Project Library for Ruby on Rails Accelerator Boot Camp
# refactored version

class Library
    
    @@catalog = [] 
    attr_accessor :number_of_shelves, :library_catalog

	def initialize
		  @@catalog = ["The Tunel", "The Search", "The Stranger", "The Painted Bird", 
			         "The Unbearable Lightness of Being","The Book of Laughter and Forgetting", "The Trial", 
			         "The World According to Garp"]
	end
    

   def return_catalog
      return @@catalog
  end
end

class Shelves

	@@shelves = Hash.new(0)
	@@number_of_shelves = 0
	@@book_list = []


	def initialize(book_list)
		puts "Shelf Created"
		@@book_list = book_list
	end

	def populate_library_to_shelf
		array = @@book_list.each_slice(5).to_a
		count = 1

		array.each do | x|
			@@shelves.merge!(count=>x)
			count += 1
		end
		@@number_of_shelves = @@shelves.count
		return @@shelves
	end
    
    def check_in_book(book)
    	@book = book
    	count_of_shelves = @@shelves.count
    	num_books_on_shelf = @@shelves[count_of_shelves].count

    	if num_books_on_shelf == 5
    		count_of_shelves += 1
    		@@shelves.merge!(count_of_shelves=>[@book])
    	else
    		(@@shelves[count_of_shelves] ||= []) << @book
    	end
        
    end

	def return_shelf_count
		return @@number_of_shelves
	end
end

class Book
    
    attr_accessor :title
    
    def enshelf(title,shelves)
    	@title = title
    	@shelves = shelves
    	
    	shelf = @shelves.select{ |k,v| v.include?(@title)}.keys.first
    end

    def unshelf(title,shelves)
    	@title = title
    	@shelves = shelves
    	shelf = @shelves.select{ |k,v| v.include?(@title)}.keys.first
    	@shelves[shelf].reject!{ |b| b == @title}
    	puts @shelves
    end
end
 
#instnatiate Library
my_library = Library.new

#Library is responsible for maitaining which books are held
puts my_library.return_catalog

#Instantiate Shelf which divides the catalog into corresponding shelves
my_shelf = Shelves.new(my_library.return_catalog)
shelved_catalog = my_shelf.populate_library_to_shelf

#Inform library of the number of shelves
my_library.number_of_shelves = my_shelf.return_shelf_count
puts "#{my_library.class} has #{my_library.number_of_shelves} shelves"

#test the addition of three new books
my_book = Book.new()
my_book.title = "The Plague"
puts my_book.title
book2 = Book.new()
book2.title = "The Kingdom of this World"
book3 = Book.new()
book3.title ='Murphy'

#check shelf to determine if a book is available
search_title = "The Stranger"
check_shelf = my_book.enshelf(search_title, shelved_catalog)
if check_shelf != nil 
	puts "The book you requested #{search_title} is on shelf #{check_shelf}"
else
	puts "The book you requested is not shelved"
end

#check in a news books and verify if the shelves are updated
my_shelf.check_in_book(my_book.title)
my_shelf.check_in_book(book2.title)
my_shelf.check_in_book(book3.title)

puts
puts "Check out The Stranger"
puts
check_shelf = my_book.unshelf(search_title,shelved_catalog)
if check_shelf != nil
	puts
	puts "There appears to be an error, please refer to librarian for assistance"
else
	puts
	puts "You have successfully checked out the book"
end
