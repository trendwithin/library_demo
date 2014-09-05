# Project Library for Ruby on Rails Accelerator Boot Camp

class Library
	@@number_of_shelves = 0
	@@library_catalog = ["The Tunel", "The Search", "The Stranger", "The Painted Bird", "Labyrinths","Catch 22"]
    @@checked_in = ["The Tunel", "The Search", "Catch 22"]
	def initialize
		  puts "Library Created"
	end

	def number_of_shelves(number_of_shelves)
		@@number_of_shelves = number_of_shelves
	end

	def get_library_catalog
		return @@library_catalog
	end

	def library_shelves
		return @@number_of_shelves
	end

end

class Shelf
    @@number_of_shelves = 0
    @@shelves = Hash.new(0)
    @@tally_of_books = 0

	def initialize(book_list) 
		puts "Shelf Created"
		@book_list = book_list
		@@tally_of_books = @book_list.count
	end

	def return_number_of_shelves
		return @@number_of_shelves
	end

	def list_of_shelves
		return @@shelves
	end

	def populate_library_to_shelf
        array = @book_list.each_slice(5).to_a
        count = 1
        
        array.each do | x |
        	@@shelves.merge!(count=>x)
        	count +=1
        end
        @@number_of_shelves = @@shelves.count
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
			@checked_in << @book
		end
	end

end

class Book

   def initialize(title)
   	  @title = title
   	  puts "Book Created"
   end

   def enshelf(title, shelves)
   	   @title = title
   	   @shelves = shelves
       @enshelf = ""
   	   @shelves.each do | k,v|
   	   	puts "#{k} and #{v}"
   		 if v.include?(@title)
   			@enshelf = "#{k}"

   		  else
   			@enshelf = false
   		  end
   	end
      return @enshelf
   end
   
   def unshelf(title, shelves)
   	  
   	  @title = title
   	  @shelves = shelves

   	  @shelves.each do | x |
   	  if x == @title
   	  	#puts "match"
   	  end
   	end
   end


end


#three classes
my_library = Library.new
my_shelf = Shelf.new(my_library.get_library_catalog)
my_book= Book.new("As I Lay Dying")


#Library  print catalog
puts my_library.get_library_catalog

#populte the shelves with the library catalog and return the total num of shelves
my_shelf.populate_library_to_shelf
number_of_shelves = my_shelf.return_number_of_shelves
list_of_shelves = my_shelf.list_of_shelves

#Shelves populated- Library now has access to number of shelves 
my_library.number_of_shelves(number_of_shelves)
print "The number of shelves in the library: "
print my_library.library_shelves
puts ""
#check if the book is on the shelf
shelf = my_book.enshelf("Catch 22", list_of_shelves)
if shelf != false
	puts "The book was found on shelf " + shelf
else
	puts "The book is not currently on the shelf"
end

#remove the book from the shelf
my_book.unshelf("The Stranger", list_of_shelves)
#puts "After Deletion"
#puts my_library.get_library_catalog


