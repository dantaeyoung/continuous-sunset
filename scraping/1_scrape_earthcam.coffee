Xray = require("x-ray")
x = Xray()

url = 'http://search.earthcam.com/search/adv_search.php?restrict=1&refreshRate[]=Streaming&&vars=0:2672:1:0'

x(url, "div.result_item", [
  location: '.cam_location'
  title: '.camTitle'
  url: '.camTitle@href'
  cam_type: '.cam_type_image@title'
  result_bottom: '.result_bottom'
])
    .paginate("span[style*='color:#509CE1'] a@href")
    .limit(2)
    .write "5pageresults.json"
