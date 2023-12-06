from pymongo import MongoClient
import requests
from lxml import html


client = MongoClient("localhost", 21017)
db = client['mongo_db']
ya_news = db.ya_news

ya_news_url = 'https://dzen.ru/news?issue_tld=ru'
headers = {"User-Agent": r"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
                         r"Chrome/119.0.0.0 Safari/537.36"}

response = requests.post(ya_news_url, headers=headers, allow_redirects=True)
dom = html.fromstring(response.text)

source = dom.xpath("//span[@class='mg-card-source__source']//text()")
time = dom.xpath("//span[@class='mg-card-source__time']/text()")
news = dom.xpath("//h2/a/text()")
links = dom.xpath("//h2/a/@href")

for i in range(0, len(news)):
    ya_news.insert_one({'source': source[i],
                        'news': news[i],
                        'links': links[i],
                        'time': time[i]
                        })


