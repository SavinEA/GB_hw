import os
from time import sleep

"""--------------------------------------------Задание №1: Класс светофор--------------------------------------------"""
# Запускал в командной строке под Win10. По идее, os.system('cls||clear') должно работать под Lixux и MacOS тоже
class Traffic_light:

    __red = '\033[31m'
    __yellow = '\033[33m'
    __green = '\033[32m'
    __white = '\033[37m'
    __color = (__red, __yellow, __green)
    __timer = (7, 3 ,5)
    __TO = 3
    __count_for_TO = 0

    def __init__(self, command):
        self.command = command

    def _print_view(self, text_color, num):
        if text_color == self.__red:
            print(f'{self.__red}({num})\n{self.__white}(0)\n{self.__white}(0)')
        elif text_color == self.__yellow:
            print(f'{self.__white}(0)\n{self.__yellow}({num})\n{self.__white}(0)')
        elif text_color == self.__green:
            print(f'{self.__white}(0)\n{self.__white}(0)\n{self.__green}({num})')
        else:
            print('Светоформ не исправен!')
            print(f'{self.__white}(X)\n{self.__white}(X)\n{self.__white}(X)')

    def running(self):
        if self.command == 'start':
            os.system('cls||clear')
            while self.__count_for_TO < self.__TO:
                for i in range(3):
                    for el in range(self.__timer[i], 0, -1):
                        self._print_view(self.__color[i], el)
                        sleep(1)
                        os.system('cls||clear')
                self.__count_for_TO += 1
            print(f'{self.__white}Светофор отключен. Необходимо ТО.')
        else:
            raise Exception('Неверная команда, попробуйте еще раз')

t_l = Traffic_light('start')
try:
    t_l.running()
except Exception as err:
    print(f'{err}')

"""---------------------------------------------Задание №2: Класс дорога---------------------------------------------"""
class Road:
    __weight_kv_m = 25

    def __init__(self, length, width):
        self.length = length
        self.width = width

    def weight_of_asphalt(self, hight):
        weight = self.length * self.width * self.__weight_kv_m * hight
        return weight

my_road = Road(5000, 20)
print(f'Чтобы положить асфальт на дорогу потребуется: {my_road.weight_of_asphalt(5) / 1000} тонн')

"""--------------------------------------Задание №3: Классы работник, должность--------------------------------------"""
class Worker:

    def __init__(self, name, surname, position, income):
        self.name = name
        self.surname = surname
        self.position = position
        self._income = income

class Position(Worker):

    def __init__(self, name, surname, position, income):
        super().__init__(name, surname, position, income)

    def get_full_name(self):
        return f'{self.surname} {self.name}'

    def get_total_income(self):
        return sum(self._income.values())


petrov_income = {
    'wage': 100000,
    'bonus': 50000
}
petrov = Position('petr', 'petrov', 'manager', petrov_income)
full_name = petrov.get_full_name()
total_income = petrov.get_total_income()
print(f'Сотрудник {full_name} зарабатывает: {total_income} рублей')

"""---------------------------------------Задание №4: Класс авто с подклассами---------------------------------------"""
class Car:

    def __init__(self, speed, color, name, is_police):
        self.speed =  speed
        self.color = color
        self.name = name
        self.is_police = bool(is_police)

    def go(self):
        print(f'Автомобиль {self.name} начал движение')

    def stop(self):
        print(f'Автомобиль {self.name} остановился')

    def turn(self, direction):
        if direction == 'прямо':
            print(f'Автомобиль {self.name} продолжил движение прямо')
        elif direction == 'влево':
            print(f'Автомобиль {self.name} повернул на лево')
        elif direction == 'вправо':
            print(f'Автомобиль {self.name} повернул на право')
        else:
            print(f'Автомобиль {self.name} сбился с курса')

    def show_speed(self):
        print(f'Скорость автомобиля {self.name}: {self.speed} км/ч')

class TownCar(Car):

    def __init__(self, speed, color, name, is_police, type):
        super().__init__(speed, color, name, is_police)
        self.type = type

    def show_speed(self):
        if self.speed < 60:
            print(f'Скорость автомобиля {self.name}: {self.speed} км/ч')
        else:
            print(f'Автомобиль {self.name} превысил допустимую скорость 60 км/ч')

class WorkCar(Car):

    def __init__(self, speed, color, name, is_police, type):
        super().__init__(speed, color, name, is_police)
        self.type = type

    def show_speed(self):
        if self.speed < 40:
            print(f'Скорость автомобиля {self.name}: {self.speed} км/ч')
        else:
            print(f'Автомобиль {self.name} превысил допустимую скорость 40 км/ч')

class SportCar(Car):

    def __init__(self, speed, color, name, is_police, type):
        super().__init__(speed, color, name, is_police)
        self.type = type

    def show_speed(self):
        if self.speed > 180:
            print(f'Скорость автомобиля {self.name}: {self.speed} км/ч')
        else:
            print(f'Автомобиль {self.name} не такой уж и спортивный')

class PoliceCar(Car):
    def __init__(self, speed, color, name, is_police, type):
        super().__init__(speed, color, name, is_police)
        self.type = type

    def cop_or_not(self):
        if self.is_police == True:
            print(f'Автомобиль {self.name} c полицейской расскраской')
        else:
            print(f'Автомобиль {self.name} под прикрытием')

test_car = Car(220, 'BACLAJAN', 'LADA_SEDAN', 1)
test_car.go()
test_car.stop()
test_car.turn('прямо')
test_car.turn('влево')
test_car.turn('вправо')
test_car.turn('дергай ручник')
test_car.show_speed()

test_town_car = TownCar(65, 'white', 'toyta camry 3.5', 0, 'Town')
test_town_car.show_speed()

test_work_car = WorkCar(45, 'yellow', 'vw_polo', 0, 'Work')
test_work_car.show_speed()

test_sport_car = SportCar(60, 'blue with white line', 'lambo', 0, 'Sport')
test_sport_car.show_speed()

test_cop_car = PoliceCar(50, 'black', 'ford focus', 0, 'Police')
test_cop_car.cop_or_not()

"""----------------------------------Задание №5: Класс канцелярская принадлежность-----------------------------------"""
class Stationery:
    def __init__(self, title):
        self.title = title

    def drow(self):
        return 'Запуск отрисовки'

class Pen(Stationery):
    def __init__(self, title):
        super().__init__(title)

    def drow(self):
        return 'Штриховка ручкой'

class Pencil(Stationery):
    def __init__(self, title):
        super().__init__(title)

    def drow(self):
        return 'Набросок карандашом'

class Handle(Stationery):
    def __init__(self, title):
        super().__init__(title)

    def drow(self):
        return 'Обвести контуры маркером'

coal = Stationery('Уголек')
print(f'Берем {coal.title}: {coal.drow()}')

pen = Pen('Ручка')
print(f'Берем {pen.title[0:-1]}у: {pen.drow()}')

pencil = Pencil('Карандаш')
print(f'Берем {pencil.title}: {pencil.drow()}')

handle = Handle('Маркер')
print(f'Берем {handle.title}: {handle.drow()}')



