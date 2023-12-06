from pymongo import MongoClient
from bs4 import BeautifulSoup as bs
import requests


def add_new_vacancy(hh, name, link, salary_min, salary_max, salary_currency, company_site):
    if hh.find_one({'link': link}):
        print(f'{link} уже есть в базе')
    else:
        hh.insert_one({'name': name,
                       'link': link,
                       'salary_min': salary_min,
                       'salary_max': salary_max,
                       'salary_currency': salary_currency,
                       'company_site': company_site
                       })
        print(f'{link} найдена новая вакансия')

def search_salary(hh, salary_min, salary_max):
    result = hh.find({'$and': [{'salary_min': {'$gte': salary_min}}, {'salary_max': {'$lte': salary_max}}]})
    for el in result:
        print(el)

# for doc in authors.find({'$and': [{'age': {'$gte': 29}}, {'age': {'$lte': 36}}]}):


client = MongoClient("localhost", 21017)
db = client['mongo_db']
hh = db.hh

page_count = 0
hh_url = r'https://hh.ru/search/vacancy'
headers = {"User-Agent": r"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
                         r"Chrome/119.0.0.0 Safari/537.36"}

while page_count >= 0:
    params = {"ored_clusters": "true",
              "area": "1",
              "hhtmFrom": "vacancy_search_list",
              "hhtmFromLabel": "vacancy_search_line",
              "text": "ml",
              "enable_snippets": "false",
              "salary": "155000",
              "only_with_salary": "true",
              "page": f"{page_count}"
              }
    response = requests.get(hh_url, headers=headers, params=params)
    dom = bs(response.text, 'html.parser')

    next_page = dom.find('a', {'data-qa': 'pager-next'})
    if next_page is None:
        page_count = -1
    else:
        page_count += 1

    vacancies = dom.select('.serp-item')
    for vacancy in vacancies:
        job_info = vacancy.find('a', {'class': 'serp-item__title'})
        name = job_info.text
        link = job_info.get('href')

        salary_info = vacancy.find('span', {'class': 'bloko-header-section-2'}).text
        try:
            if salary_info.lower().find('от') == 0:
                salary_list = salary_info.split(' ')
                salary_min = int(salary_list[1].replace(' ', ''))
                salary_max = None
            elif salary_info.lower().find('до') == 0:
                salary_list = salary_info.split(' ')
                salary_min = None
                salary_max = int(salary_list[1].replace(' ', ''))
            else:
                salary_list = salary_info.split(' ')
                salary_min = int(salary_list[0].replace(' ', ''))
                salary_max = int(salary_list[2].replace(' ', ''))
            salary_currency = salary_list[-1]
        except:
            salary_min = None
            salary_max = None
            salary_currency = None

        company_link = vacancy.find('a', {'class': 'bloko-link'}).get('href')
        response_company = requests.get(f'https://hh.ru{company_link}', headers=headers)
        try:
            dom_company = bs(response_company.text, 'html.parser')
            company_site = dom_company.find('button', {'data-qa': 'sidebar-company-site'}).findChild().text
        except:
            company_site = None

        add_new_vacancy(hh, name, link, salary_min, salary_max, salary_currency, company_site)

search_salary(hh, 100000, 300000)
