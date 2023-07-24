# Welcome to My Basecamp 1
MyBasecamp1 is a web-based project management tool inspired by the original Basecamp. It allows users to create accounts, log in, and manage projects. The application is divided into three parts: User Registration, Session Management, and Project Management.
---

## Task
The tasks are splitted into three parts which include:
### User Registration

- `User #new`: Allows users to register and create a new account.
- `User #show`: Displays the user's profile information and project list.
- `User #create`: Handles the registration form submission and creates a new user in the database.
- `User #destroy`: Allows administrators to delete a user from the system.
### Role Permission

- `User setAdmin`: Allows administrators to grant admin permissions to a user.
- `User removeAdmin`: Allows administrators to revoke admin permissions from a user.

### Project Management

- `Project #new`: Enables users to create a new project.
- `Project #show`: Displays the project details and associated tasks.
- `Project #edit`: Allows users to modify the project details.
- `Project #destroy`: Enables users to delete a project.

## Description

MyBasecamp1 is a web-based project management tool inspired by the original Basecamp. It allows users to create accounts, log in, and manage projects. The application is divided into three parts: User Registration, Session Management, and Project Management.
---

### Technical Details

This project is built using Ruby on Rails. The application includes a database for storing user and project information, a backend for handling user authentication and project management, and a frontend built with bootstrap for delivering a seamless user experience.


## Installation

1. Install Ruby, Node.js, rails  on your local machine.
2. Clone this repository: `git clone git@git.us.qwasar.io:my_basecamp_1_143355_lnjvw4/my_basecamp_1.git`
3. Navigate to the project directory: `cd MyBasecamp_1`
4. Install dependencies: `bundle install`
5. Set up the database: `rails db:migrate`
6. To set up an admin account for testing run the following commands
    - `rails c`
    - `user = user = User.new(email: "admin@gmail.com", firstname: "super", lastname: "admin",password: "password", password_confirmation: "password")`
    - `user.role = 1`
    - `user.save`
7. Start the application: `rails server`
8. Access the application in your browser at the address and port number displayed by puma on the terminal

## Usage

1. Use the account created above to login and access admin privillages

2. navigate through the user friendly interface to use the application

### The Core Team
Mangut Innocent Amos (innocent_m)
Ayotunde Adeboyeje (adeboyej_a)

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
