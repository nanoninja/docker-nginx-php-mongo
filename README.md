# Nginx PHP MongoDB

Docker running Nginx, PHP-FPM, MongoDB.

**THIS ENVIRONMENT SHOULD ONLY BE USED FOR DEVELOPMENT!**

**DO NOT USE IT IN PRODUCTION!**

## Images to use

* [Nginx](https://hub.docker.com/_/nginx/)
* [MongoDB](https://hub.docker.com/_/mongo/)
* [PHP-FPM](https://hub.docker.com/r/nanoninja/php-fpm/)
* [Composer](https://hub.docker.com/r/composer/composer/)
* [Generate Certificate](https://hub.docker.com/r/jacoelho/generate-certificate/)

## Start using it

1. Download it :

    ```sh
    $ git clone https://github.com/nanoninja/docker-nginx-php-mongo.git
    ```

2. Run :

    ```sh
    $ docker-compose up -d
    ```

3. Open your favorite browser :

    * [http://localhost:8000](http://localhost:8000/)
    * [https://localhost:3000](https://localhost:3000/) ([HTTPS](https://github.com/nanoninja/docker-nginx-php-mongo#generating-ssl-certificates) not configured by default)

## Directory tree

```sh
docker-nginx-php-mongo
├── README.md
├── bin
│   └── linux
│       └── clean.sh
├── data
│   └── db
│       ├── dumps
│       └── mongo
├── docker-compose.yml
├── etc
│   ├── nginx
│   │   └── default.conf
│   ├── php
│   │   └── php.ini
│   └── ssl
└── web
    ├── app
    │   ├── composer.json
    │   ├── src
    │   └── tests
    └── public
        └── index.php
```

## Connecting from PHP

[Documentation](http://php.net/manual/fr/set.mongodb.php)

```php
<?php
$manager = new MongoDB\Driver\Manager("mongodb://mongo:27017/test");

$bulk = new MongoDB\Driver\BulkWrite();
$bulk->insert(['name' => 'John Doe']);

$writeConcern = new MongoDB\Driver\writeConcern(MongoDB\Driver\WriteConcern::MAJORITY, 100);
$result = $manager->executeBulkWrite('test.mycollection', $bulk);

var_dump($result);
?>
```

## Updating composer
```shell
docker run --rm -v $(pwd)/web/app:/app -v ~/.ssh:/root/.ssh composer/composer update
```

## Connecting to mongodb
```shell
docker exec -it mongo bash
```

## Creating database exports

```sh
mongoexport --port 27020 --db test --collection mycollection --out $(pwd)/data/db/dumps/mycollection.json
```

## Creating database dumps

```sh
mongodump --port 27020 --db test --collection mycollection --out $(pwd)/data/db/dumps
```

## Generating SSL certificates

1. Generate certificates

    ```sh
    $ docker run --rm -v $(pwd)/etc/ssl:/certificates -e "SERVER=localhost" jacoelho/generate-certificate
    ```

2. Configure Nginx

    Edit nginx file **etc/nginx/default.conf** and uncomment the server section.

    ```nginx
    # server {
    #     ...
    # }
    ```

## Cleaning project

**Warning**: Clears all containers and volumes.

```sh
$ ./bin/linux/clean.sh $(pwd)
```
