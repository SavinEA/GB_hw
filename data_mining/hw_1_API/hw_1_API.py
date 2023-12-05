import requests
import json


url = r'https://api.github.com/users/SavinEA/repos'
token = r'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'
headers = {"Accept": "application/vnd.github+json",
           "Authorization": f"Bearer {token}",
           "X-GitHub-Api-Version": "2022-11-28",
           "User-Agent": r"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}

response = requests.get(url, headers=headers)
with open('my_repo.json', 'w') as file:
    json.dump(response.text, file)

repo_list = json.loads(response.text)
for repo in repo_list:
    print(f'Ссылка к репозиторию {repo["full_name"]}: {repo["html_url"]}')
