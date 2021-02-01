# Задание №1
a = 1
b = 1.1
c = 'text'
print(f'a = {a}\nb = {b}\nc = {c}')

i = input('Введите целое число: ')
f = input('Введите вещественное число: ')
s = input('Введите строку: ')
print(f'\nВведенные данные:\nЦелое число: {i}\nВещественное число: {f}\nСтрока: {s}')

# Задание №2
import datetime
while(True):
    time = input('Введите количество секунд от 0 до 86399: ')
    if time.isdigit() == 0:
        print('Ошибка! Введите целое положительное число!')
    elif int(time) > 86399:
        print('Ошибка! Введите число в диапазоне от 0 до 86399!')
    else:
        break
print(time)
s = int(time)%60
m = int(time)//60
h = m//60
m = m%60
print(datetime.time(h,m,s))

# Задание №3
while(True):
    n = input('Введите целое положительное число от 1 до 9: ')
    if n.isdigit() == 0:
        print('Ошибка! Введите целое положительное число!')
    elif int(n) < 1 or int(n) > 9:
        print('Ошибка! Введите число в диапазоне от 1 до 9!')
    else:
        break
i = int(n)
sum = 0
while i > 0:
    sum = sum + int(n*i)
    i-=1
print(sum)

# Задание №4
while(True):
    x = input('Введите целое положительное число: ')
    if x.isdigit() == 0:
        print('Ошибка! Введите целое положительное число!')
    else:
        break
i = len(x)
max = 0
while i > 0:
    if int(x[i-1]) > max:
        max = int(x[i-1])
    i-=1
print(f'Самая большая цифра: {max}')

# Задание №5
gain = float(input('Введите выручку фирмы: '))
cost = float(input('Введите издержки фирмы: '))
count = gain - cost
if count > 0:
    print('Фирма работает с прибылью!')
    print(f'Рентабельность фирмы: {round((count/gain), 2)}')
    personal = int(input('Введите количество сотрудников: '))
    print(f'Прибыль фирмы на каждого сотрудника составляет: {count/personal}')
else:
    print('Фирма работает в убыток')

# Задание №6
a = float(input('Введите начальный результат спортсмена в км.: '))
b = float(input('Введите желаемый результат спортсмена в км.: '))
day = 0
km = a
while km < b:
    day += 1
    km = km + km * 0.1
    print(f'{day} день, результат: {round(km, 2)}')
print(f'На {day}-й день спортсмен достигнет желаемый результат')