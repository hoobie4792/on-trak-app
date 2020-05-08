# On Trak Rails App
On Trak is a Rails application that creates online to-do lists to be shared among Users.  The purpose of this application is to encourage efficient collaboration and accountability on shared tasks.  


## Prerequisites
The install steps require the following on your system
* Github
* Ruby 2.6.1
* faker gem

## Install Intructions

  1. Clone git@github.com:hoobie4792/on-trak-app.git to you local machine.
  2. Once cloned, navigate to the base folder of this repositry.
  3. Run $ bundle install in the terminal to install required gems.
  4. Run $ rails s to start application.  
  5. You can now run the app on localhost:3000


## Application Structure and Rules
 Login
 * Users may create an account by Signing Up with a username and password. 
 * Username and password must be provided and must be unique among users. 
 * Once a user has signed up they may sign in with username/password combo they provided.


## Features
  On Trak has several features designed to make task collaboration easy and flexible between Users.
* Users can search for and add other Users to an existing or new group.
* Groups can be updated by name and members.  
* Users can create to-do lists by name and due date and add collaborators to that list.
* Lists are updated and sorted with items specified by assigned user, priority, due-date, and categories. 
* Users can edit and update lists they are collaborators on.  Only the group owner may delete lists.
* Lists appear on the current users show page by date due, allowing for easy interpretation.
