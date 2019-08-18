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