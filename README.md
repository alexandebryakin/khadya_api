# Weuse API

# Initial setup

→ Clone the repo

→ Install `docker` and `docker-compose`

→ Copy env file by:

```bash
cp .example.env .env
```

→ Build docker by using:

```bash
docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml build
```

## Start the app in the `development` environment by:

```bash
docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml up -d
```

## Stop the app in the `development` environment by:

```bash
docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml down
```

## To run RSpecs:

```bash
# Creates and migrates test database
docker-compose -f ./docker-compose.yml -f ./docker/test/docker-compose.yml run --rm app rails db:create db:migrate

# Runs the specs
docker-compose -f ./docker-compose.yml -f ./docker/test/docker-compose.yml run --rm app rspec
# docker-compose -f ./docker-compose.yml -f ./docker/development/docker-compose.yml --env-file .env.test run -e RAILS_ENV=test --rm app rspec
```
