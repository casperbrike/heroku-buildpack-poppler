# heroku-buildpack-poppler

Heroku Buildpack for [poppler](https://poppler.freedesktop.org/) library (v.22.04.0)

## Usage

Simply add the buildpack to your Heroku app, e.g.

```bash
heroku buildpacks:add -a MY-APP https://github.com/casperbrike/heroku-buildpack-poppler
```

## Update buildpack to support other version of poppler

Firstly, update `Dockerfile` to include your desired version of poppler (replace `<version>` with your version):

```docker
ARG version=<version>
```

Then run following commands to produce the Debian package (replace `<version>` with your version):

```bash
docker build --build-arg version=<version> -t casperbrike/poppler:<version> .
docker run --rm -v `pwd`:/mnt casperbrike/poppler:<version> cp /poppler/build/poppler_<version>-1_amd64.deb /mnt/
```

Update `bin/compile` file with name of your new package (replace `<version>` with your version):

```
PKG=poppler_<version>-1_amd64.deb

```

Commit and push changes and you're ready to go!
