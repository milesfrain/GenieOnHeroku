This project hosts a minimal [Genie.jl](https://github.com/GenieFramework/Genie.jl) web app on Heroku using a [julia buildpack](https://github.com/Optomatica/heroku-buildpack-julia).


Steps:
```
git clone https://github.com/milesfrain/GenieOnHeroku.git
cd GenieOnHeroku
HEROKU_APP_NAME=my-app-name
heroku create $HEROKU_APP_NAME --buildpack https://github.com/Optomatica/heroku-buildpack-julia.git
git push heroku master
heroku open -a $HEROKU_APP_NAME
heroku logs -tail -a $HEROKU_APP_NAME
```

I was previously attempting to host on heroku by uploading docker containers, but encountered lots of issues. Moved that troubleshooting effort to a [separate branch](https://github.com/milesfrain/GenieOnHeroku/tree/dockerfile) in this repo.

### GUI Guide (no terminal)

Here's a [guide](https://gist.github.com/fonsp/38965d7595a5d1060e27d6ca2084778d) on how to deploy to Heroku without any of the above CLI commands. Thanks to [@fonsp](https://github.com/fonsp) for the writeup.
