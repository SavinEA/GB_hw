# Задание №1
print('\nЗадание №1')
b0 = bool(0)
b1 = bool(1)
i0 = int(0)
i1 = int(1)
ls1 = [b0, b1, i0, i1, 2, 2.2, 'str', ['a', 'b', 'c']]
print(ls1)

i=0
while i < len(ls1):
    print(f' Класс {i}-го элемента {ls1[i]} - {type(ls1[i])}')
    i += 1

# Задание №2
print('\nЗадание №2')
str2 = input('Введите элементы через пробел: ')
print(f'Получившаяся строка: {str2}')

ls2 = str2.split()
print(f'Преобразуем строку в список: {ls2}')

i2 = 0
res2 =[]
while i2 < len(ls2):
    if len(ls2) % 2 == 0:
        res2.append(ls2[i2+1])
        res2.append(ls2[i2])
        i2 += 2
    else:
        if len(ls2) - i2 == 1:
            res2.append(ls2[i2])
            i2 += 1
        else:
            res2.append(ls2[i2 + 1])
            res2.append(ls2[i2])
            i2 += 2
print(f'Результирующий список: {res2}')

# Задание №3
print('\nЗадание №3')
ls3 = ['Зима', '12', 'декабрь', '1', 'январь', '2', 'февраль',
       'Весна', '3', 'март', '4', 'апрель', '5', 'май',
       'Лето', '6', 'июнь', '7', 'июль', '8', 'август',
       'Осень', '9', 'сентябрь', '10', 'октябрь', '11', 'ноябрь']

dct3 = {'Зима': {'12': 'декабрь', '1': 'январь', '2': 'февраль'},
        'Весна': {'3': 'март', '4': 'апрель', '5': 'май'},
        'Лето': {'6': 'июнь', '7': 'июль', '8': 'август'},
        'Осень': {'9': 'сентябрь', '10': 'октябрь', '11': 'ноябрь'}}

str3 = input('Введите номер месяца: ')
print(f'Используем список\nВаш месяц: {ls3[int(ls3.index(str3))+1]} и это {ls3[(int(ls3.index(str3))//7)*7]}')
for i3 in dct3.keys():
    for j3 in dct3[i3].keys():
        if j3 == str3:
            print(f'Используем словарь\nВаш месяц {dct3[i3][j3]} и это {i3}')

# Задание №4
print('\nЗадание №4')
str4 = input('Введите строку: ')
ls4 = str4.split()
i4 = 0
while i4 < len(ls4):
    if len(ls4[i4]) < 10:
        print(f'{i4+1} - {ls4[i4]}')
        i4 += 1
    else:
        print(f'{i4 + 1} - {ls4[i4][:10:1]}')
        i4 += 1

# Задание №5
print('\nЗадание №5')
import copy
ls5 = [7, 5, 3, 3, 2]
str5 = None
print('Структура "Рейтинг". Чтобы закончить ввод данных наберите stop')
while True:
    str5 = input('Введите новый элемент рейтинга: ')
    if str5 == 'stop':
        break
    else:
        i5=0
        tmp_ls = copy.deepcopy(ls5)
        while i5 < len(tmp_ls):
            if int(str5) > tmp_ls[i5]:
                tmp_ls.insert(i5, int(str5))
                break
            elif i5 == (len(tmp_ls)-1):
                tmp_ls.append(int(str5))
                break
            else:
                i5 += 1
        print(f'Пользователь ввел число {str5}. Результат: {tmp_ls}')

# Задание №6
print('\nЗадание №6')
products = [(1, {'название': 'компьютер', 'цена': 20000, 'количество': 5, 'eд': 'шт.'}),
            (2, {'название': 'принтер', 'цена': 6000, 'количество': 2, 'eд': 'шт.'}),
            (3, {'название': 'сканер', 'цена': 2000, 'количество': 7, 'eд': 'шт.'})]
dict_of_products = {}

for key in products[0][1].keys():
    i6 = 0
    tmp = []
    while i6 < len(products):
        tmp.append(products[i6][1][key])
        i6 += 1
    dict_of_products.update({key: set(tmp)})
print(dict_of_products)
