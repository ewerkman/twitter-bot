# Commerce Tweet Bot

A bot that searches twitter for specific keywords and tweets them out. Using PostgreSQL to store the ID of the last tweet to use in the search query.

Twitter Gem
- [https://github.com/sferik/twitter](https://github.com/sferik/twitter)

Twitter API Reference
- [https://dev.twitter.com/rest/reference](https://dev.twitter.com/rest/reference)

PostgreSQL Gem
- [https://rubygems.org/gems/pg/versions/0.18.4](https://rubygems.org/gems/pg/versions/0.18.4)

PostgreSQL Docs (v9.3)
- [https://www.postgresql.org/docs/9.3/static/index.html](https://www.postgresql.org/docs/9.3/static/index.html)

Heroku Developer Guide (Ruby)
- [https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction](https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction)
- `heroku pg:psql` to login to remote db
- `heroku logs --tail` to see logs for running processes
- `heroku pg:credentials DATABASE` to get the credentials and connection string for remote DB

Cloud 9
- `c9 open ~/.bashrc` to edit local bash profile, and add environment variables
- `sudo service postgresql start` to start local psql instance
- `psql DATABASE` to login to local SQL instance