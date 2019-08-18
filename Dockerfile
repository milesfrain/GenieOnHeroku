FROM julia:1.1

ADD *.toml /app/
ADD /src /app/src/
WORKDIR /app

# Trying to speed things up by installing dependencies in container
RUN julia -e 'using Pkg; pkg"activate ."; pkg"instantiate"; using GenieOnHeroku'

CMD julia -e 'using Pkg; pkg"activate ."; pkg"instantiate"; using GenieOnHeroku; GenieOnHeroku.launchServer('$PORT')'
