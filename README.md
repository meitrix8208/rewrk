# image rewrk

## build

```bash
docker build -t rewrk .
```

## run

```bash
docker run --rm -it --name rewrk-test-api rewrk
```

## example of usage

```bash
 rewrk -d 3s -h <http://192.168.0.1:5000/api/users>
```
