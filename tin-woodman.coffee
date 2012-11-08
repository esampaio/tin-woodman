casper = require('casper').create()
x = require('casper').selectXPath
url = 'http://jundiai.ginfes.com.br/'
user = ''
password = ''

iss_id = casper.cli.args[0]

unless iss_id? and iss_id > 0
  console.log 'You need to pass a valid service invoice number as a parameter.'
  console.log '    eg: casperjs tin-woodman.coffee <invoice number>'
  casper.exit()

casper.on 'page.created', (newPage) ->
  newPage.onPageCreated = (page) ->
    page.onResourceReceived = (response) ->
      console.log "Downloading: " + response.url + ' into ./xmls/' + iss_id + '.xml' if response.stage = 'end'
      casper.download(response.url, 'xmls/' + iss_id + '.xml') if response.stage = 'end'
      casper.exit()

casper.start url

casper.thenClick '.imagem1'

casper.thenClick '#gwt-uid-3'

casper.then ->
  @fill 'form#ext-gen70', {
    'ext-gen31': user,
    'ext-gen33': password
  }, false

casper.thenClick 'button#ext-gen42'

casper.waitForSelector x('//div[@class="linkLateral" and a[text()="Consultar"]]'), ->
  @click x('//div[@class="linkLateral" and a[text()="Consultar"]]')

casper.waitForSelector x('//form[div[label[text()="Número NFS-e:"]]]//input'), ->
  # 'workaround' aka gambi because GWT fucking sucks
  input_name = @fetchText(x('//form[div[label[text()="Número NFS-e:"]]]//input[1]/@name'))
  values = {}
  values[input_name] = iss_id
  
  @fill x('//form[div[label[text()="Número NFS-e:"]]]'), values, false
  @click x('//button[text()="Consultar"]')

casper.wait 10000, ->
  @click x('//div[@class="x-column-inner" and descendant::label[text()="Clique na imagem ao lado para baixar o arquivo de resposta."]]//img[1]')

casper.wait 15000

casper.run()
