This is a sample application for the course 1DV42E

## Tasks for both
- [X] Set up application for migrations
- [X] Create models
- [X] Generate a migrations
- [X] Migrate a simple migration
- [X] Create a one-to-many relationship migration
- [ ] Create a many-to-many relationship migration
- [X] Add an attribute
- [X] Remove a column
- [X] Make a column non nullable
- [X] Referential Integrity
- [X] Seeding the database
- [X] Remove a table
- [ ] Default values
- [X] Clear the db
- [X] Rollback migration

## Rails specific tasks

## Tasks

NOTE: Depending on your bundler version, you might want to prepend ```bundle exec``` to all of the commands
listed. If you dont you might get a warning about using another version of bundler than the one used by your
rails application.

### 1. Set up application for migrations  
http://edgeguides.rubyonrails.org/active_record_migrations.html
The Ruby on Rails documentation has a whole section on migrations. 
Migrations are supported out of the box in Rails so there is no need to configure anything.

### 2. Create models
The 2.2 Section, Model generators shows the command used to generate a model which is simplu running
```$ bin/rails generate model Event ```. To add attributes at the same time just supply them as arguments
```$ bin/rails generate model Event name:string ```

This generates a model class in the app/models folder. Even though we supplied a name-attribute to the generator
this isnt visible in the classes. Rails does not show attributes in the models, and this is pretty frustrating.
Instead, you have to look in db/schema.rb to determine what attributes a model has, or make comments in the 
model class.

The Model-generator also generates a migration for the model, not unlike the Code First approach
in ASP.NET MVC. Examining the migration we see that there is a create_table :events statement. Rails
has a convention that tables are named in plural, as are controllers. Here we also see that the table is
created with a string column and also t.timestamsp, which are a way for rails to keep track of when
the post is created/updated.

According to the documentation, create_table will create a PK named id. This name can be changed by
adding an attribute and supplying the :primary_key option.

### 3. Migrate a simple migration.

Lets migrate our migration. To find the command for running a migration, one has to scroll pretty long 
down the very longt documentation page for migrations, almost to long. Its found under 4 Running Migrations,
but would have been better off after the Create Models section.
THe command to run a migration is ```$ bin/rails db:migrate ```. You can also supplu a VERSION= param to migrate
to a specified version. 

Inspecting the development SQlite database located in the db-folder, we see that a table called events
has been created with the columns id, name, created_at and updated_at.

### 4. Create a simple migration/Add an attribute in the same task
Now you dont always remember to add all attributes in the model generation so you can also create standalone migrations
2.1 Creating a standalone migration lists the command needed 
```$ bin/rails generate migration AddDateToEvent ```
then we write this in our migration file
```ruby
  add_column :events, :date, :datetime
```
first param is the table, second is the column name and third is the type
and then migrate and the database has the new column!

if you want to generate the adding of the column write this instead
```$ bin/rails generate migration AddDateToEvent date:datetime```

### 5. Creating the one to many migration.
The migration section has nothing on relations, but luckily there is a whole section on this.
Relations are called Associtations in rails http://guides.rubyonrails.org/association_basics.html.
Here its clear that the one-to-many relation is first declared in the model with the 
```has_many :events```
but first we need to create the model
```rails g model venue```

Then some changes are needed in the migration generated. But since we have already created the event-model
which the venue will have many of, we need to alter the table. There was no good documentation on how
to do this when the table already exists, only if the table is created. If the table event would be created
in the same time you would use t.belongs_to :venue, index: true. 

In the migrations-documentation there is documented how to do this.
Either you generate a new migration "AddVenueRefToEvent vnue:references" or
type "add_refernce :events, :venue, index: true.
The documentaiton also recommends adding a foreign key constraint to ensure referntial integrity.
This was in another part and would not have been found if not for skimmering through and ctrl-f foreing key.

to do this we add these 2 statements to the migration
```ruby
  add_reference :events, :venue, :index: true
  add_foreign_key :events, :venues
```

Now the events are referenced. 

If we open our rails console and try some things out, like creating a
Venue and a Event, we see that the Venue has a ActiveRecord 

and execute our migration via command line


### 6. Seeding the database
Now lets seed the database with some data!
No one can miss the seeds.rb file in db-folder, and it actually contains comments on how to seed db with data!
Lets follow that and try it.

Then we run rake db:seed and our data is in the database!

### 7. Removing a table
To remove a table I had to goole "drop table rails" and got a hit in 
http://api.rubyonrails.org/classes/ActiveRecord/Migration.html
here it is clear that the drop_table :table_name command does this.
drop_table is irreversible by default, to make it reversible you have to supply a block
describing how to recreate the table again, unlike Entity Framework that gives you 
a down block that creates the table again


### 8. Clear the db
This one was found at stackoverflow and no official documentation was found when googling
you run the command "rake db:schema:load" that recreates the database from the schema.rb and purges 
all data. Should really be an official part of documentation.

There is however documentation on how to reset the database, rake db:reset. THis also seeds the database (i think)
and result in a massive error/warning message but still works.

### 9. Rollback a migration
Also found in the documentation 5 Changing Existing Migrations.
To rollback a migration run the command  
rake db:rollbak

### 10. make column non-nullable
To make a column non-nullbale, we look at 3.4 changing columns in ARmigrations on edgeguidesrails.
There we see that there is a method called change_column_null :table, :column, true/false.
So you generate a migration and write ```change_column_null :events, :name, false```, run the
migration and viola, the column is non-nullable!

### 11. Referntial integrity
According to the documentation for Active Record, the active record way claims that intelligence belongs
in your models, not the database. Therefor features such as triggers or constraints are not heavily useds.
THe validation should be enforced in the model.
This is done via 
```validates :foreign_key, uniqueness: true ``` to enforce data integrity if its a one-to-one 
the :dependent option on associations allow models to automatically destroy childs when parents are destroyed
We add it to venues to ensure all events connected to that venue are destroyed when the venue is removed.
The documentation states that referntial integrity cannot be guaranteed using this method, so you can 
also augument them with a foreign key constraing in the database.
```add_foreign_key :events, :venues``

### 12. Remove a column
The migration doc states that you can generate a migration to remove a column this way  
```$rails generate migration RemoveNameFromEvent name:string```

this generates a migration that has a 
```remove_column :events, :name, :string```
pretty nifty that you dont have to write anything if you name your migration correctly and
provide the right arguments.

If we run this the name column dissapears











