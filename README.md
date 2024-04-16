## Local Setup

### clone recursively

    git clone --recursive git@github.com:MartinRenze/martin-renze.de.git

### start development environment

    nix-shell setup.nix

### start server

    hugo serve -D

## Deploy

The deployment to netlify is done by pushing merging changes into main
