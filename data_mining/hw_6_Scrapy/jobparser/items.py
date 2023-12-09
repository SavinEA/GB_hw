import scrapy


class JobparserItem(scrapy.Item):
    name = scrapy.Field()
    salary = scrapy.Field()
    url = scrapy.Field()
    min_salary = scrapy.Field()
    max_salary = scrapy.Field()
    cur_salary = scrapy.Field()
    _id = scrapy.Field()
