# Задание №1
def div (a, b):
    return  a / b

a = float(input('Введите число а = '))
b = float(input('Введите число b = '))

try:
    div(a, b)
except ZeroDivisionError:
    print('Ошибка! Деление на ноль!')
else:
    print(f'Результат деления a на b = {div(a, b)}')

# Задание №2
def personal_data (name, surname, bday_year, city, email, phone, *args):
    print(f'Имя: {name} \nФамилия: {surname} \nГод рождения: {bday_year} \nГород: {city} \nПочта: {email} \nТелефон: {phone}')

personal_card = ('Евгений', 'Савин', 1990, 'Губкинский', 'test@gmail.com', '+7(777)777-77-77')
personal_data(*personal_card)

# Задание №3
def sum_max (x, y, z):
    l = [x, y, z]
    l.remove(min(l))
    sum_max= int(l[0])+int(l[1])
    return sum_max

print(f'Сумма максимальных элементов составляет: {sum_max(1, 3, 5)}')

# Задание №4
def degree (x, y):
    result = 1
    count = 0
    if y < 0:
        while count > y:
            result = result * x
            count -= 1
        result = 1 / result
    else:
        while count < y:
            result = result * x
            count += 1
    return result
x = 5.5
y = -2
print(x**y)
print(degree(x, y))

# Задание №5
def sum_list (*args):
    count = 0
    result = 0
    while count < len(args):
        result = result + float(args[count])
        count += 1
    return result

sum = 0
while True:
    str = input('Введите числа через пробел: ')
    ls =str.split()
    if ls[-1] == 'stop':
        sum = sum + sum_list(*ls[0:-1])
        print(f'Сумма элемнтов строки = {sum}')
        break
    else:
        sum = sum + sum_list(*ls)
        print(f'Сумма элемнтов строки = {sum}')

# Задание №6
print('При помощи двух функций')
def words (str):
    ls = str.split()
    count = 0
    result_str = []
    while count < len(ls):
        result_str.append(word(ls[count]))
        count += 1
    return result_str

def word (text):
    result = text.capitalize()
    return result

str = input('Введите слово: ')
print(word(str))

str = input('Введите строку: ')
print(words(str))

print('При помощи декоратора')
def deco (func):
    def func_param (str):
        ls = str.split()
        count = 0
        str_result = []
        while count < len(ls):
            str_result.append(func(ls[count]))
            count += 1
        return str_result
    return func_param

@deco
def word_d (str):
    result = str.capitalize()
    return result

str = input('Введите строку: ')
print(word_d(str))

