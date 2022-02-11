# Chitter

A twitter clone that allows users to post messages to a public stream.

## User stories

**[View peeps](https://trello.com/c/Vtxx99y1):**
```
As a... user
I want... to see peeps
So that... I can see what other people are saying
```

**[Add peeps](https://trello.com/c/ZAXgeRjL):**
```
As a... user
I want... to post a peep
So that... I can let people know what I'm doing
```

**[Order peeps by chronological order](https://trello.com/c/c2JzuC9k):**
```
As a... user
I want... to see all peeps in reverse chronological order
So that... I can see what others are saying most recently
```

**Display when a peep was created:**
```
As a... user
I want... to see the time at which it was made
So that... I can better appreciate the context of a peep
```

**Sign up and log in:**
```
As a... user
I want... to sign up for Chitter
So that...  I can post messages on Chitter as me
```

```
As a... user
I want... to log in to Chitter
So that...  I can post messages on Chitter as me
```

**Delete peeps:**
```
As a... user
I want... to delete my own peep
So that... I can remove a peep I'm no longer happy with
```

**Update peeps:**
```
As a... user
I want... to update my own peep
So that... I can update a peep if I've made a typo
```

**Comment on a peep:**
```
As a... user
I want... to comment on a peep
So that... I can interact with others users via their peeps
```

## Trello board
https://trello.com/b/RnC9pnmw/chitter-sinatra

## Heroku link
https://secret-basin-74632.herokuapp.com/

## Set up databases

Set up development database:
1. Open postrges by entering `psql` in the terminal
2. Run the command `CREATE DATABASE chitter_sinatra;` to create the database
3. Connect to the database using the command `\c chitter_sinatra;`
4. Run the query saved in `01_create_peeps_table.sql`

Set up test database:
1. Open postrges by entering `psql` in the terminal
2. Run the command `CREATE DATABASE chitter_sinatra_test;` to create the database
3. Connect to the database using the command `\c chitter_sinatra_test;`
4. Run the query saved in `01_create_peeps_table.sql`
