# Specifications for the Sinatra Assessment

Specs:

- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (e.g. User, Post, Category)
  * Used User and Project models.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  * User has_many Projects
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  * Project belongs_to User
- [x] Include user accounts with unique login attribute (username or email)
  * Username is what I used for a unique attribute that is validated by User model
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  * Project belongs_to User and can be Created, Read, Updated and Destroyed, and routes are present for all.
- [x] Ensure that users can't modify content created by other users
  * Users can only update/destroy Projects that belong to them
- [x] Include user input validations
  * POST routes include validations for input.
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [*] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message