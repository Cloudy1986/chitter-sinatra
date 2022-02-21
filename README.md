# Chitter

A twitter clone that allows users to post messages to a public stream.

## User stories

**[View peeps](https://trello.com/c/Vtxx99y1):** ✅
```
As a... user
I want... to see peeps
So that... I can see what other people are saying
```

**[Add peeps](https://trello.com/c/ZAXgeRjL):** ✅
```
As a... user
I want... to post a peep
So that... I can let people know what I'm doing
```

**[Order peeps by chronological order](https://trello.com/c/c2JzuC9k):** ✅
```
As a... user
I want... to see all peeps in reverse chronological order
So that... I can see what others are saying most recently
```

**[Display when a peep was created](https://trello.com/c/V1jMAkdk):** ✅
```
As a... user
I want... to see the time at which it was made
So that... I can better appreciate the context of a peep
```

**[Sign up and log in](https://trello.com/c/Y9vDL34A):** ✅
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

**[Log out](https://trello.com/c/iSStYvGB):** ✅

```
As a... user
I want... to log out of Chitter
So that...  someone can't post messages as me
```

**[Delete peeps](https://trello.com/c/E5rouDrf):** ✅
```
As a... user
I want... to delete my own peep
So that... I can remove a peep I'm no longer happy with
```

**[Update peeps](https://trello.com/c/0qveNaX2):** ✅
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

## Setting up and running the app

1. Clone this repo
2. Run `bundle install` via your terminal
3. Set up your development database:
    * Open postrges by entering `psql` in the terminal
    * Run the command `CREATE DATABASE chitter_sinatra;` to create the database
    * Connect to the database using the command `\c chitter_sinatra;`
    * Run the query saved in `01_create_peeps_table.sql`
    * Run the query saved in `02_create_users_table.sql`
    * Run the query saved in `03_add_column_peeps_table.sql`
    * Run the query saved in `04_create_comments_table.sql`
    * Run the query saved in `05_add_column_comments_table.sql`
    * Run the query saved in `06_add_column_comments_table.sql`
4. Set up your test database:
    * Open postrges by entering `psql` in the terminal
    * Run the command `CREATE DATABASE chitter_sinatra_test;` to create the database
    * Connect to the database using the command `\c chitter_sinatra_test;`
    * Run the query saved in `01_create_peeps_table.sql`
    * Run the query saved in `02_create_users_table.sql`
    * Run the query saved in `03_add_column_peeps_table.sql`
    * Run the query saved in `04_create_comments_table.sql`
    * Run the query saved in `05_add_column_comments_table.sql`
    * Run the query saved in `06_add_column_comments_table.sql`
5. Start the server using `rackup` in the terminal
6. Visit your local host and start playing with the app!
