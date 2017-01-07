## Generating SSL certificates

```shell
docker run --rm -v $(pwd)/etc/ssl:/certificates -e "SERVER=localhost" jacoelho/generate-certificate
```

## Updating composer
```shell
docker run --rm -v $(pwd)/web/app:/app -v ~/.ssh:/root/.ssh composer/composer update
```

## Connecting to mongodb
```shell
docker exec -it mongo bash
```
