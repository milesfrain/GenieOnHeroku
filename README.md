Looks like the main challenge is to reduce memory footprint to the 512MB threshold.
It might be possible to address this in the `Dockerfile`.
I was attempting to install all julia dependencies in the `RUN` step, but code is re-downloaded during the `CMD` step too.
These installation and build steps appear to be skipped when running the container locally.

I suspect that even if the footprint is reduced, there will still be other strange Heroku errors, such as those [reported here](https://github.com/milesfrain/JosekiHerokuExample) when using a lighter-weight module.


Steps to reproduce the problem:
```
git clone https://github.com/milesfrain/GenieOnHeroku.git
cd GenieOnHeroku
heroku login
heroku container:login
HEROKU_APP_NAME="my-app-name"
heroku create $HEROKU_APP_NAME
heroku container:push web --app $HEROKU_APP_NAME
heroku container:release web --app $HEROKU_APP_NAME
heroku logs --tail --app $HEROKU_APP_NAME
```

Errors
```
Starting process with command `/bin/sh -c julia\ -e\ \'using\ Pkg\;\ pkg\"activate\ .\"\;\ pkg\"instantiate\"\;\ using\ GenieOnHeroku\;\ GenieOnHeroku.launchServer\(\'\56204\'\)\'`
Cloning default registries into `~/.julia`
Cloning registry from "https://github.com/JuliaRegistries/General.git"
    Fetching: [>                                        ]  0.0 %
Cloning git-repo `https://github.com/genieframework/Genie.jl`
    Fetching: [>                                        ]  0.0 %
Installed CodeTracking ─────── v0.5.7
Installed OrderedCollections ─ v1.1.0
Installed Gumbo ────────────── v0.5.1
Installed TextWrap ─────────── v0.3.0
Installed Nettle ───────────── v0.4.0
Installed HTTP ─────────────── v0.8.4
Installed Revise ───────────── v2.1.6
Installed Parsers ──────────── v0.3.6
Installed LoweredCodeUtils ─── v0.3.6
Installed JuliaInterpreter ─── v0.6.1
Installed URIParser ────────── v0.4.0
Installed BinDeps ──────────── v0.8.10
Installed YAML ─────────────── v0.3.2
Installed ArgParse ─────────── v0.6.2
Installed MiniLogging ──────── v0.2.0
Installed Reexport ─────────── v0.2.0
Installed Compat ───────────── v2.1.0
Installed BinaryProvider ───── v0.5.6
Installed MbedTLS ──────────── v0.6.8
Installed JSON ─────────────── v0.21.0
Installed Millboard ────────── v0.2.0
Installed Codecs ───────────── v0.5.0
Installed HttpCommon ───────── v0.5.0
Installed Nullables ────────── v0.0.8
Installed AbstractTrees ────── v0.2.1
Building Gumbo ──→ `~/.julia/packages/Gumbo/G7Qbw/deps/build.log`
Building Nettle ─→ `~/.julia/packages/Nettle/SES5O/deps/build.log`
Building MbedTLS → `~/.julia/packages/MbedTLS/X4xar/deps/build.log`
Process running mem=613M(119.6%)
Error R14 (Memory quota exceeded)
```

The command to run the container locally, which works fine:
```
docker run --rm -p 8000:8000 -e PORT=8000 registry.heroku.com/$HEROKU_APP_NAME/web
```

Can test with:
```
curl 172.17.0.2:8000
```

Can find IP in docker with:
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' name-of-your-container
```

Container name found with:
```
docker container ls
```
