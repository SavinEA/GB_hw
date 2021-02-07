# Задание №1
with open('file1.txt', 'w', encoding='UTF-8') as f:
    while True:
        str = input('Введите строку для записи в файл: ')
        if len(str) != 0:
            f.write(str + '\n')
        else:
            break

# Задание №2
with open('file1.txt', 'r', encoding='UTF-8') as f:
    text = f.read()
    str = text.split('\n')
    print(f'В файле {len(str)} строки')
    for words in str:
        word = words.split()
        print(f'    В строке "{words}" - Количество слов = {len(word)}')
        for letters in word:
            print(f'        В слове "{letters}" - Количество букв = {len(letters)}')

# Задание №3
with open('file3.txt', 'r', encoding='UTF-8') as f:
    text = f.read()
    str = text.split('\n')
    average_value = 0
    print('У следующих сотрудников оклад ниже 20 т.р.:')
    for persons in str:
        person = persons.split()
        average_value += int(person[-1])
        if int(person[-1]) < 20000:
            print(person[0])
    average_value = average_value / len(persons)
    print(f'\nСредний оклад работников составляет: {average_value}')

# Задание №4
print('Решение с использованием словаря')
translate = {'One': 'Один', 'Two': 'Два', 'Three': 'Три', 'Four': 'Четыре'}
with open('file4_read.txt', 'r', encoding='UTF-8') as f_read:
    with open('file4_write.txt', 'w', encoding='UTF-8') as f_write:
        for line in f_read:
            str = line.split()
            d = translate.get(str[0])
            f_write.write(f'{d} {str[1]} {str[2]}\n')

with open('file4_write.txt', 'r', encoding='UTF-8') as f_write:
    print(f_write.read())

# Задание №5
with open('file5.txt', 'w', encoding='UTF-8') as f_write:
    str = input('Введите последовательность чисел через пробел: ')
    f_write.write(str)

with open('file5.txt', 'r', encoding='UTF-8') as f_read:
    text = f_read.read()
    str = text.split()
    summa = 0
    for el in str:
        summa += int(el)
    print(f'Сумма элементов в файле: {summa}')

# Задание №6
with open('file6.txt', 'r', encoding='UTF-8') as f:
    d = {}
    for line in f:
        str = line.split(':')
        lesson = str[0]
        other = str[1].split()
        sum_hour = 0
        for el in other:
            hour = el.split('(')
            if hour[0].isdigit():
                sum_hour += int(hour[0])
        print(sum_hour)
        d.update({lesson:sum_hour})
    print(d)

# Задание №7
with open('file7_read.txt', 'r', encoding='UTF-8') as f_read:
    result_ls = []
    average_profit = 0
    for line in f_read:
        d_firm = {}
        firm = line.split()
        profit = int(firm[2]) - int(firm[3])
        d_firm.update({firm[0]:profit})
        result_ls.append(d_firm)
        if profit > 0:
            average_profit += profit
    average_profit = round((average_profit / len(line)), 2)
    result_ls.append({'average_profit':average_profit})
    print(result_ls)

import json
with open('file7_json.json', 'w', encoding='UTF-8') as f_json:
    json.dump(result_ls, f_json, ensure_ascii = False)
