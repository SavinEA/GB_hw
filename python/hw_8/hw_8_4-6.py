class Storage:
    office_equipments_on_storage = {}

    def __init__(self, rack, rack_space):
        if type(rack) == int:
            self._rack = rack
        else:
            raise ValueError('Укажите количестов стелажей целочисленным числом(Int)')
        if type(rack_space) == int:
            self._rack_space= rack_space
        else:
            raise ValueError('Укажите количестов маст на стелаже целочисленным числом(Int)')
        self._total_space = rack * rack_space
        self.count_empty_place = self._total_space
        self._matrix_of_space = []
        m_rack = 0
        while m_rack < rack:
            m_rack_space = 0
            temp_rack = []
            while m_rack_space < rack_space:
                temp_rack.append(0)
                m_rack_space += 1
            self._matrix_of_space.append(temp_rack)
            m_rack += 1

    def empty_rack_space(self, rack_number):
        count_empty_rack_space = 0
        for place in self._matrix_of_space[rack_number - 1]:
            if place == 0:
                count_empty_rack_space += 1
            else:
                pass
        return count_empty_rack_space

    def put_on_rack(self, tech_count, rack_number):
        if tech_count <= self.empty_rack_space(rack_number):
            self.count_empty_place -= tech_count
            count = self._rack_space - self.empty_rack_space(rack_number)
            tech_count += count
            while count < tech_count:
                self._matrix_of_space[rack_number - 1][count] = 1
                count += 1
            return rack_number
        else:
            raise ValueError(f'Недостаточно места на стелаже №{rack_number}')

    def put_on_empty_place(self, tech_count):
        if tech_count <= self.count_empty_place:
            self.count_empty_place -= tech_count
            rack_count = 0
            while rack_count < self._rack and tech_count != 0:
                space_count = 0
                while space_count < self._rack_space and tech_count != 0:
                    if self._matrix_of_space[rack_count][space_count] == 0:
                        self._matrix_of_space[rack_count][space_count] = 1
                        tech_count -= 1
                        space_count += 1
                    else:
                        space_count += 1
                rack_count += 1
        else:
            raise ValueError(f'Недостаточно места на складе')
        return rack_count

    def take_from(self, rack_number):
        self._matrix_of_space[rack_number - 1][self._rack_space - self.empty_rack_space(rack_number) - 1] = 0
        self.count_empty_place += 1

    def clear_storage(self):
        self._matrix_of_space.clear()
        m_rack = 0
        while m_rack < self._rack:
            m_rack_space = 0
            temp_rack = []
            while m_rack_space < self._rack_space:
                temp_rack.append(0)
                m_rack_space += 1
            self._matrix_of_space.append(temp_rack)
            m_rack += 1
        self.count_empty_place = self._total_space

    def stocks(self):
        list_of_equipment = self.office_equipments_on_storage.keys()
        print('Перечень техники на складе:')
        for equipment in list_of_equipment:
            print(f'\t{equipment} (Стелаж №{equipment.place_on_storage})')
        return list_of_equipment

    def type_of_stocks(self):
        scaners = 0
        printers = 0
        xerosxers = 0
        mfuers = 0
        list_of_equipment = self.office_equipments_on_storage.keys()
        for equipment in list_of_equipment:
            if type(equipment) == Scaner:
                scaners += 1
            elif type(equipment) == Printer:
                printers += 1
            elif type(equipment) == Xserox:
                xerosxers += 1
            elif type(equipment) == OfficeEquipment:
                mfuers += 1
            else:
                print('Неопознаный предмет на складе')
        print(f'На складе:\nСканеры\t\t- {scaners} шт.\n'
              f'Принтеры\t- {printers} шт.\nКсероксы\t- {xerosxers} шт.\nМФУ\t\t\t- {mfuers} шт.')

    def __str__(self):
        print_matrix = f'Общее количество свободных мест: {self.count_empty_place} из {self._total_space}'
        num = 1
        for line in self._matrix_of_space:
            print_matrix += f'\nСтелаж №{num}: '
            for place in line:
                if place == 0:
                    print_matrix += '|_|'
                else:
                    print_matrix += '|X|'
            num += 1
        return print_matrix


class OfficeEquipment:
    def __init__(self, manufacturer, model, serial_number):
        self.manufacturer = manufacturer
        self.model = model
        self.serial_number = serial_number
        self.place_on_storage = -1

    def __hash__(self):
        return hash((self.manufacturer, self.model, self.serial_number))

    def __eq__(self, other):
        return (self.manufacturer, self.model, self.serial_number) == (other.manufacturer, other.model, other.serial_number)

    def ship_to_storage(self, storage_number: Storage):
        if self.place_on_storage == -1:
            self.place_on_storage = Storage.put_on_empty_place(storage_number, 1)
            storage_number.office_equipments_on_storage.update({self: self.place_on_storage})
        else:
            Storage.take_from(storage_number, self.place_on_storage)
            self.place_on_storage = Storage.put_on_empty_place(storage_number, 1)
            storage_number.office_equipments_on_storage.update({self: self.place_on_storage})

    def ship_to_rack_on_storage(self, storage_number, rack_number):
        if self.place_on_storage == -1:
            self.place_on_storage = Storage.put_on_rack(storage_number, 1, rack_number)
            storage_number.office_equipments_on_storage.update({self: self.place_on_storage})
        else:
            Storage.take_from(storage_number, self.place_on_storage)
            self.place_on_storage = Storage.put_on_rack(storage_number, 1, rack_number)
            storage_number.office_equipments_on_storage.update({self: self.place_on_storage})

    def send_to_the_company(self, storage, company):
        storage.take_from(self.place_on_storage)
        self.place_on_storage = -1
        print(f'{self}, отправлен на склад {company}')

    def __str__(self):
        return f'{self.manufacturer} {self.model} s/n:{self.serial_number}'


class Printer(OfficeEquipment):
    color_printing = {0: 'Черно-белая печать',
                      1: 'Цветная печать'}
    double_sided_printing = {0: 'Одностороняя печать',
                             1: 'Двустороняя печать'}

    def send_to_print(self, sheet_count, key_for_color_printing, key_for_double_sided_printing):
        print(f'Принтер {self.model} s/n:{self.serial_number} печатает {sheet_count} страниц\n'
              f'Настройки: {self.color_printing[key_for_color_printing]}, '
              f'{self.double_sided_printing[key_for_double_sided_printing]}')


class Scaner(OfficeEquipment):
    color_scaning = {0: 'Черно-белый скан',
                     1: 'Цветной скан'}
    quality_scaning = {100: '100x100 пикселей - низкое качество',
                       300: '300х300 пикселей - среднее качество',
                       600: '600х600 пикселей - высокое качество'}
    address_book = {'Ivanov': 'ivanov_iiI@mail.ru',
                    'Petrov': 'petrov_pp@mail.ru',
                    'Suvorov': 'suvorov_ss@mail.ru',}

    def scan_to_mail(self, key_for_color_scaning, key_for_quality_scaning, surname_from_address_book):
        print(f'Cканер {self.model} s/n:{self.serial_number} отправляет документ на почту: '
          f'{self.address_book[surname_from_address_book]}\n'
          f'Настройки: {self.color_scaning[key_for_color_scaning]}, '
          f'{self.quality_scaning[key_for_quality_scaning]}')


class Xserox(OfficeEquipment):
    def __str__(self):
        return 'Спишиет меня уже пожалуйста, я так устал'

    def for_cutting_sanwich(self, *args):
        print('На ксероксе нарезали следующие продукты:')
        for food in args:
            print(food)


storage1 = Storage(5, 5)
print(storage1)
# storage1.put_on_rack(4, 1)
# # print(storage1)
# storage1.put_on_rack(2, 2)
# print(storage1)
# # storage1.put_on_rack(3, 3)
# # print(storage1)
# # storage1.put_on_rack(2, 4)
# # print(storage1)
# # storage1.put_on_rack(5, 5)
# # print(storage1)
# #
# # # storage1.put_on_empty_place(1)
# # place = storage1.put_on_empty_place(2)
# # print(place)
# # print(storage1)
# # storage1.take_from(2)
# # print(storage1)
# # storage1.clear_storage()
# # print(storage1)
#
mfu = OfficeEquipment('HP', 'LJ 1522f', 123456)
print(mfu)
mfu.ship_to_storage(storage1)
print(storage1)
mfu.ship_to_rack_on_storage(storage1, 4)
print(storage1)

printer_HP_2 = Printer('HP_2', 'noLJ', 112323)
printer_HP_2.ship_to_rack_on_storage(storage1, 5)

printer_HP = Printer('HP', 'LJ', 123)
printer_HP.ship_to_storage(storage1)
print(storage1)
# print(printer_HP)
# printer_HP.send_to_print(20, 1, 0)
#pr
scaner_Kyocera = Scaner('Kyocera', 2040, 345)
scaner_Kyocera.ship_to_storage(storage1)
print(storage1)
# print(scaner_Kyocera)
# scaner_Kyocera.scan_to_mail(1, 300, 'Suvorov')
#
# good_old_xserox = Xserox('Xerox', 'x255', 228)
# print(good_old_xserox)
# good_old_xserox.for_cutting_sanwich('хлеб', 'колбаса', 'сыр')
storage1.stocks()
storage1.type_of_stocks()

scaner_Kyocera.send_to_the_company(storage1, 'Gazprom')
print(storage1)

try:
    test_storage1 = Storage('пять', 5)
except ValueError as err:
    print(f'Ошибка ввода данных! {err}')

try:
    test_storage2 = Storage(5, 'пять')
except ValueError as err:
    print(f'Ошибка ввода данных! {err}')
