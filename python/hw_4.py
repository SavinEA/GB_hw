# Задание №1
from sys import argv

def zp (hour, money, bonus):
    result = int(hour)*int(money)+int(bonus)
    return result

print(f'Запаботная плата работника составит: {zp(*argv[1:4])}$')

# Задание №2
ls = [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55]
result_ls = []
count = 1
while count < len(ls):
    if ls[count] > ls[count-1]:
        result_ls.append(ls[count])
        count += 1
    else:
        count += 1
print(result_ls)

# Задание №3
ls = [x for x in range(20, 240) if (x % 20 == 0 or x % 21 == 0)]
print(ls)

# Задание №4
ls =  [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11]
result_ls = [x for x in ls if ls.count(x) < 2]
print(result_ls)

# Задание №5
from functools import reduce

def product_of_number (x, y):
    result = int(x) * int(y)
    return result

def factorial (ls):
    result = 1
    for x in ls:
        result = result * int(x)
    return result

ls = [x for x in range(100, 1001) if x % 2 == 0]
print(ls)
print(reduce(product_of_number, ls))
print(factorial(ls))

# Задание №6/a
from itertools import count
from time import sleep, strftime
from datetime import datetime
from sys import argv

def argv_count (numb, sec):
    sec = int(sec)
    numb = int(numb)
    start = datetime.now()
    for x in count(numb):
        stop = datetime.now()
        if (int(strftime("%S", datetime.timetuple(stop))) - int(strftime("%S", datetime.timetuple(start)))) < sec:
            print(x)
            sleep(1)
        else:
            break

argv_count(*argv[1:3])

# Задание №6/b
from itertools import cycle
from time import sleep, strftime
from datetime import datetime
from sys import argv

def argv_cycle (sec, *args):
    sec = int(sec)
    start = datetime.now()
    print(args)
    for x in cycle(args):
        stop = datetime.now()
        if (int(strftime("%S", datetime.timetuple(stop))) - int(strftime("%S", datetime.timetuple(start)))) < sec:
            print(x)
            sleep(1)
        else:
            break

argv_cycle(*argv[1:])

# Задание №7
def fact(n):
    count = 1
    result = 1
    while count <= n:
        result = result * count
        yield result
        count += 1

n = int(input('Введите число: '))
for el in fact(n):
    print(el)