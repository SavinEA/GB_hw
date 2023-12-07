from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common import exceptions
from pymongo import MongoClient


client = MongoClient("localhost", 21017)
db = client['mongo_db']
magnit = db.magnit

chrome_options = Options()
chrome_options.add_argument('start-maximized')
driver = webdriver.Chrome(options=chrome_options)
wait = WebDriverWait(driver, 20)
driver.get('https://magnit.ru/promo')

alco_button = wait.until(EC.visibility_of_element_located((By.XPATH, "/html/body/main/footer/div[3]/div[1]/button")))
try:
    alco_button.click()
except:
    pass

while True:
    try:
        button = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='paginate__more']")))
        button.click()
    except exceptions.TimeoutException as e:
        print('Finish')
        break

goods = driver.find_elements(By.XPATH, "//a[@class='new-card-product']")
for good in goods:
    accessible_name = good.accessible_name
    link = f"https://magnit.ru{good.get_attribute('href')}"
    try:
        discount = good.find_element(By.XPATH, "//div[@class='new-card-product__badge']").text
    except:
        discount = None

    magnit.insert_one({'accessible_name': accessible_name,
                       'link': link,
                       'discount': discount
                       })
