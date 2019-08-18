FROM julia:1.1

ADD *.toml /app/
ADD /src /app/src/
WORKDIR /app

# Trying to speed things up by installing dependencies in container
RUN julia -e 'using Pkg; pkg"activate ."; pkg"instantiate"; pkg"precompile"'

CMD julia -e 'using Pkg; pkg"activate ."; using GenieOnHeroku; GenieOnHeroku.launchServer('$PORT')'
