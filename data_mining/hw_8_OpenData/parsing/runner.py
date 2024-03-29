from scrapy.crawler import CrawlerProcess
from scrapy.settings import Settings


from parsing import settings
from parsing.spiders.insta_com import InstaComSpider

if __name__ == '__main__':
    crawler_settings = Settings()
    crawler_settings.setmodule(settings)

    process = CrawlerProcess(settings=crawler_settings)
    process.crawl(InstaComSpider)
    process.start()
