# Borg documentation

The [`master`](https://github.com/mikesmullin/borg-docs/tree/master) branch contains the production copy of the dynamic (Jade, Stylus, Coffee) documentation for [Borg](http://github.com/mikesmullin/borg).

The [`develop`](https://github.com/mikesmullin/borg-docs/tree/develop) branch contains the working development copy of dynamic documentation.

The [`gh-pages`](https://github.com/mikesmullin/borg-docs/tree/gh-pages) branch contains the latest production snapshot static HTML copy of the documentation.  
Hosted by Github Pages at [http://mikesmullin.github.io/borg-docs/](http://mikesmullin.github.io/borg-docs/)

## Starting the dynamic version

```bash
git checkout master
npm install
npm start
# browse to http://localhost:3000/
```

## Publishing to the static version
```bash
git checkout gh-pages
./publish.sh
git add -A
git commit
git push
```
