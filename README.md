# Antropoloops share application

Deployed at https://atpls-share.herokuapp.com

## Install and development

- Clone this repo
- Install dependencies: `yarn`
- Start docker: `npm run docker:start`
- Start server: `npm run server`

## Deploy

```
git push heroku master

# optional
heroku run rake db:migrate
```

## Resources

https://devcenter.heroku.com/articles/heroku-postgres-import-export

## License

GNU GPLv3
