require 'sugar'
express = require 'express'
jade    = require 'jade'
stylus  = require 'stylus'
nib     = require 'nib'
path    = require 'path'
pkg     = require path.join __dirname, 'package.json'

app = express()
app.use require('morgan')('combined')
app.use require('body-parser').urlencoded extended: false
app.disable 'x-powered-by'

app.PORT   = 3000
app.APP    = path.join __dirname, path.sep
app.VIEWS  = path.join app.APP, 'views', path.sep
app.PUBLIC = path.join app.APP, 'public', path.sep

die = (reason) -> process.stderr.write "#{reason}\n"; process.exit 1
log = (msg) -> console.log msg

# Views

app.set 'views', app.VIEWS
app.set 'view engine', 'jade'
app.locals.pretty = true
app.use stylus.middleware src: path.join(app.PUBLIC), compile: (str, path) ->
  stylus(str).set('filename', path).use nib()

app.use require('connect-coffee-script')
  src: path.join app.PUBLIC
  dest: path.join app.PUBLIC
  bare: true
  force: true

app.use express.static app.PUBLIC # static file server

# Controllers

app.get '/', (req, res) ->
  chapters=[]
  current_chapter=0
  sections=[]
  current_section=0
  chapter = (name) ->
    current_chapter = chapters.push
      name: name
      sections: []
    return current_chapter+'. '+name
  section = (name) ->
    current_section = chapters[current_chapter-1].sections.push name
    return current_chapter+'.'+current_section+'. '+name
  res.render 'home',
    version: pkg.version
    borg_version:  (require 'borg/package.json').version
    node_version: process.version
    chapter: chapter
    section: section
    chapters: chapters




# Server
http = app.listen app.PORT, '0.0.0.0', ->
  log 'Listening on '+ JSON.stringify http.address()
