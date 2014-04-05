# 1.  Why do they call it a relational database?
# Data has a more structured relationship to each other view keys in a one:many or many:many quantity relationship.

# 2.  What is SQL?
# Language to retrieve/edit/delete/update/join data inside of a relational database.

# 3.  There are two predominant views into a relational database. What are they, and how are they different?
# Schema view and data view. Schema view is structure for how data and tables are organizes and data view is what is actually inside the tables as the data itself.

# 4.  In a table, what do we call the column that serves as the main identifier for a row of data? We're looking for the general database term, not the column name.
# Primary key. 

# 5.  What is a foreign key, and how is it used?
# A foreign key is the primary key of another table, used on the “many” side of one:many or many:many relationships. Used as unique identifier to link tables. 

# 6.  At a high level, describe the ActiveRecord pattern. This has nothing to do with Rails, but the actual pattern that ActiveRecord uses to perform its ORM duties.
# Each row is an object and each column has getter/setter methods. 

# 7.  If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?
# crazy_monkies

# 8.  If I'm building a 1:M association between Project and Issue, what will the model associations and foreign key be?
# Project model has “has_many :issues” and Issue model has “belongs_to :project”
# Foreign key will be “project_id” on the issues table 

# 9.  Given this code
# class Zoo < ActiveRecord::Base
# has_many :animals
# end

# • What do you expect the other model to be and what does database schema look like?
# class Animal < ActiveRecord::Base
#   belongs_to :Zoo
# end

# Database schema would probably have a string for the name of the animal, an automatically generated unique id for the animal, and a foreign key of zoo_id

# • What are the methods that are now available to a zoo to call related to animals?

# Standard array calls like size, find

# • How do I create an animal called "jumpster" in a zoo called "San Diego Zoo"?
# animal = Animal.new
# animal.name = “Jumpster”
# animal.zoo = “San Diego Zoo”

# 10. What is mass assignment? What's the non-mass assignment way of setting values?
# Mass assignment is adding data across a lot of “cells” at once.
# The non-mass way is to use the setter method on the row object

# 11. What does this code do? Animal.first
# Returns the first object in the animal table array

# 12. If I have a table called "animals" with columns called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe". Which methods makes sure it saves to the database?
# a = Animal.new
# a.name = “Joe”
# a.save

# 13. How does a M:M association work at the database level?
# Joined via a third table with two columns of foreign keys

# 14. What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?
# One is “belongs to and has many” ? quicker to build, but causes problems if need to add columns later.
# Other is “has many, through” ? better practice these days and helpful for unknown columns that will be needed later

# 15. Suppose we have a User model and a Group model, and we have a M:M association all set up. How do we associate the two?
# Under both models add “has many” and “has many, through”… set up migration/model for a joined table filled with two separate foreign keys
