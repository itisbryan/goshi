# Tab contents:
0. [App Home](https://goshi-production-d4402b141fc3.herokuapp.com/loginn)
1. [Features](#features)
2. [Local Development](#local-development)
3. [Docker Development](#docker-development)
4. [How to run test](#how-to-run-test)

# Features:
1. Sign in/ Sign up
2. List videos sharing
3. Sharing a video
4. Notify a new video sharing
# Local Development:
1. [Prerequisites](#prerequisites)
2. [Scripts](#scripts)

## Prerequisites:
1. Ruby >= 3.1.1
2. Rails >= 7.1.0
3. Node >= 18.16.0
4. Yarn >= 1.22.19
5. Postgresql >= 12

## Scripts:
    # Setting up database:
```shell
export GOSHI_DATABASE_USERNAME=<your_postgres_usename>
export GOSHI_DATABASE_PASSWORD=<your_postgres_password>
rails db:setup
bin/dev
```
# Docker Development:
1. [Prerequisites](#prerequisites-1)
2. [Scripts](#scripts-1)

## Prerequisites:
1. Docker
2. Docker Compose

## Scripts:
    # Up and running:
    docker compose up

    # Setting up database - you must  app service first:
    docker compose exec app bundle exec rails db:setup

# How to run test:
## With local machine:
    # Run unit test
    rspec
## With docker:
    # Run unit test
    docker compose run app_test bundle exec rspec

# User document:

## Brief:

- You need to sign in or sign up before access another pages
- You can switch between Sign In or Sign Up forms 
- You can sign up without confirm your email address
- Home page list all of sharing videos at once

## Tech Debt:
1. The home page still not clean about UI/UX
2. The state of components not re-rendered correctly
3. Missing some test cases

# Further improvement - future features:
1. Paginate - Infinity scroll
2. Like/Unlike
3. User's sharing videos 
4. Implement Elasticsearch for videos index 
