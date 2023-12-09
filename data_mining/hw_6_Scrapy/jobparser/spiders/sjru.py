import scrapy
from scrapy.http import HtmlResponse
from jobparser.items import JobparserItem


class SjruSpider(scrapy.Spider):
    name = 'sjru'
    allowed_domains = ['superjob.ru']
    start_urls = [
        'https://www.superjob.ru/vakansii/razrabotchik.html?geo%5Bt%5D%5B0%5D=4&click_from=facet',
        'https://spb.superjob.ru/vakansii/razrabotchik.html']

    def parse(self, response: HtmlResponse):
        next_page = response.xpath("//a[@title='дальше']/@href").get()
        if next_page:
            yield response.follow(next_page, callback=self.parse)
        links = response.xpath("//span[@class='_3xQyu _3h-Il Ev2_p _3vg36 _133uk rPK4q _2ASNn bb-JF']/@href").getall()
        for link in links:
            yield response.follow(link, callback=self.vacancy_parse)

    def vacancy_parse(self, response: HtmlResponse):
        name = response.xpath("//h1[@class='_3xQyu gzfxl a1DWm _3vg36 _133uk rPK4q bb-JF']//text()").getall()
        salary = response.xpath("//span[@class='_4Gt5t _3Kq5N']//text()").getall()
        url = response.url
        yield JobparserItem(name=name, salary=salary, url=url)
