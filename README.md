# Bulletin board

[![Actions Status](https://github.com/kitXIII/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kitXIII/rails-project-65/actions)
[![CI](https://github.com/kitXIII/rails-project-65/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/kitXIII/rails-project-65/actions/workflows/ci.yml)

Bulletin board site built with Ruby on Rails.

The [demo](https://kit-bulletins-board.onrender.com) is published on [render](https://render.com/) service

### Implementation Features

* OAuth Github authentication
* Authorization settings with [pundit](https://github.com/varvet/pundit)
* State management with [aasm](https://github.com/aasm/aasm)
* Adaptive UI with [bootstrap](https://getbootstrap.com)
* Search, filtering and sorting with [ransack](https://github.com/activerecord-hackery/ransack)
* Pagination with [kaminari](https://github.com/amatsuda/kaminari)
* Hosting files on an external service

### Development

#### Requirements

* Ruby 3.2.2 or higher

#### Github OAuth

First, you have to register you own app on [GitHubApps](https://github.com/settings/apps) and obtain `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET` to provide authorization.

1) When setting up your application on [GitHubApps](https://github.com/settings/apps) you will need the **callback url** values:

    `http://localhost:3000/auth/github/callback`

    `http://0.0.0.0:3000/auth/github/callback`


2) Also check the **"Request user authorization (OAuth) during installation"** checkbox

3) And select **"Email addresses - read-only"** in the **User permissions section**

More information about callback url [here](https://docs.github.com/apps/creating-github-apps/registering-a-github-app/about-the-user-authorization-callback-url)

More information about Github OAuth [here](https://docs.github.com/apps/building-github-apps/identifying-and-authorizing-users-for-github-apps/)


#### Local start

1) Install dependencies and prepare local database, with running:
    ```shell
    make install
    ```

2) Fill env variables in the .env file.

    Variables required for the application to work:

    `GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET` - Github OAuth settings

    `SUPERVISOR_EMAIL` - your own email to set up administrator rights for your account

3) Create your admin with SUPERVISOR_EMAIL by running:
    ```shell
    make create-admin
    ```

4) Run app locally:
    ```shell
    make start
    ```

5) Open your browser at http://localhost:3000


#### Populating the database with demo data

To populate the database with demo data (`users`, `categories`, `bulletins`), you can use the demo:create rake task:
```shell
bin/rails demo:create categories=5 users=10 bulletins=20
```

If you need to populate the database with only one type of entity, you can use one of the following commands:

```shell
bin/rails demo:create categories=3
```

```shell
bin/rails demo:categories:create number=3 # default numbers=5
```

```shell
bin/rails demo:create users=3
```

```shell
bin/rails demo:users:create number=3 # default numbers=10
```

```shell
bin/rails demo:create bulletins=5
```

```shell
bin/rails demo:bulletins:create number=5 # default numbers=10
```

#### Tests and linter check

Tests can be start using:
```shell
make test
```

Linter check can be run with:
```shell
make lint
```
