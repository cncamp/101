### Summary

- Use smaller base images
- Multi-Stage Build
- Clean all unused packages / files when create the new layer

### Use smaller base images

```shell
REPOSITORY                 TAG         IMAGE ID      CREATED       SIZE
docker.io/library/alpine   latest      14119a10abf4  6 days ago    5.87 MB
docker.io/library/busybox  latest      42b97d3c2ae9  13 days ago   1.46 MB
gcr.io/distroless/static   latest      e0851a4aa136  51 years ago  3.06 MB
```

- busybox
- alpine
- google/distroless

Example:

```dockerfile
FROM alpine:3.8

RUN apk add --no-cache \
    ca-certificates \
    git \
    gcc \
    musl-dev \
    openssl \
    go
....
```

### Multi-Stage Build

```dockerfile
FROM golang:1.10-alpine3.8 AS multistage

RUN apk add --no-cache --update git

WORKDIR /go/src/api
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build

##

FROM alpine:3.8
COPY --from=multistage /go/bin/api /go/bin/
EXPOSE 3000
CMD ["/go/bin/api"]
```

### Clean all unused packages / files when create the new layer

```dockerfile
ADD https://example.com/big.tar.xz /usr/src/things/
RUN tar -xJf /usr/src/things/big.tar.xz -C /usr/src/things
RUN make -C /usr/src/things all
```

instead of

```dockerfile
RUN mkdir -p /usr/src/things \
    && curl -SL https://example.com/big.tar.xz \
    | tar -xJC /usr/src/things \
    && make -C /usr/src/things all
```

---

```dockerfile
RUN apt-get update && apt-get install -y \
  bzr \
  cvs \
  git \
  mercurial \
  subversion \
  # Don't remmeber remove apt cache
  && rm -rf /var/lib/apt/lists/*
```

### References

[Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

https://github.com/docker-library/buildpack-deps/blob/master/Dockerfile.template

https://www.digitalocean.com/community/tutorials/how-to-optimize-docker-images-for-production
