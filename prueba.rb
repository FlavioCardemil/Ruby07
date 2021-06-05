require "uri"
require "net/http"
require "JSON"

def request(address, key)
    url = URI("#{address}&api_key=#{key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    JSON.parse response.read_body
end

body = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&', '11gksDSWBE19Zh4sbeFZfCCEHUcuKmKzDifAHrJ5')

a = []

body['photos'].each do |i|
    a.push i['img_src']
end

def build_web_page(a)
    File.open("index.html", "w") do |f|
        f.write("<html>\n")
        f.write("<head>\n<title>NASA</title>\n</head>\n")
        f.write("<body>\n")
        f.write("<ul>\n")
        a.count.times do |i|
            f.write("\t<li><img src='#{a[i]}'></li>\n")
        end
        f.write("</ul>\n")
        f.write("</body>\n</html>\n")
    end
end

build_web_page(a)