require 'active_record'

# tell active_record which database to connect to
db_options = {adapter: 'sqlite3', database: 'todos_db'}
ActiveRecord::Base.establish_connection(db_options)

# write migration class for creating Todo table in database
	### how do we write migration in rails?
class CreateTodos < ActiveRecord::Migration[5.0]
	def change
		create_table :todos do |t|
			t.string :description
		end
	end
end

# create Todo table by executing the function we just wrote
	### how do apply migration in rails?
	### why do we handle exception here?
begin
	CreateTodos.new.change
rescue ActiveRecord::StatementInvalid
	# it's probably OK
end

# create Todo class by inheriting from ActiveRecord::Base
	### how do we write new class in Rails?
	### why there's no setter and getter method (or attr_accessor)?
class Todo < ActiveRecord::Base
end

# populate the database if it is empty (avoid running this piece of code twice)
	### do you still remember this cleaner and simpler hash syntax?
		# old version: new_hash = {:simon => "Talek", :lorem => "Ipsum"}
if Todo.all.empty?
	Todo.create(description: "prepare for discussion section")
	Todo.create(description: "release cs169 hw3")
end
