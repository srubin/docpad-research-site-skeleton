# docpad-research-site-skeleton
A docpad skeleton for creating a static research log to share with your collaborators

## Building the site for development

`docpad run` then launch [http://localhost:9778](http://localhost:9778)

## Building a static version of the site for production

```
docpad clean
docpad generate --env=static,deploy
```

## Semi-streamlined deployment

(More info on fully streamlined deployment later!)

After building the static version, as above:

```
git subtree push --prefix out origin production
```

Then, on your server, clone the repo, and run

```
git pull origin production
```
