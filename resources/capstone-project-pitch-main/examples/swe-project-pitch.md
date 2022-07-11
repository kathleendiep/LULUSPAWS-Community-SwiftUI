# Balloonicorn - Project Pitch

A platform for creating and sharing curated lists of movies, books, and other media.

## Background

My friends and I like curating and sharing lists of content and media recommendations
around some common theme.

Sites like [letterboxd.com](letterboxd.com) and [goodreads.com](goodreads.com) allow users
to create film lists and reading lists (respectively), but there aren't any platforms I
know of that support creating lists with both films *and* books, so I was inspired to make
one for myself.

## MVP

- As a user, I want to share a profile page that shows all the lists I've ever created
  as well as share links to individual lists so others can enjoy my content.
- As a user, I want to create an ordered list of movies, books, and other media. Since
  it's important for me to explain why these pieces of media belong together or how
  they're thematically related, I want to describe the rationale behind each item's
  inclusion. I also want to give the entire list its own title and description.
- As a user, I want to be able to automatically populate metadata like title, author, year
  published, etc. for movies/books so I don't have to copy that information myself in
  order to refer to a specific title.
- As a user, I want to "follow" or "favorite" lists created by other users so I can
  bookmark lists that sound interesting to me.

## Tech stack

- **Database:** PostgreSQL
- **Backend:** Python 3
- **Frontend:** Web browser

### Dependencies

- Python packages:
  - SQLAlchemy ORM
  - Flask
  - Jinja
  - Requests
- APIs/external data sources:
  - Goodreads API: used to search for books and book metadata
  - TMDB (The Movie Database) API: used to search for movies and movie metadata
- Browser/client-side dependencies:
  - React
  - Bootstrap

## Roadmap

### Sprint 1

- User registration and authentication
- List read/write service: a RESTful API to create, read, update lists
- List item read/write service: a RESTful API to create, read, update items that appear in
  lists
- User profile page to display all lists a user has created, with links to each individual
  list

### Sprint 2

- Goodreads integration: return search results from Goodreads API and metadata for
  specific title; these will be displayed as a list of options for user to select the
  particular book they want to add to a list
- TMDB integration: same as above, for movies
- React frontend for editing lists
  - drag and drop to edit order of list item
  - search and autocomplete frontend for movies and books
  - generic content component: paste a URL and retrieve metadata (title, description) from HTML
