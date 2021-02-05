class DateCheck:
    def __init__(self, string):
        self.string = string

    def str_to_int(self):
        date_list = self.string.split('-')
        day = int(date_list[0])
        month = int(date_list[1])
        year = int(date_list[2])
        return day, month, year

    def validation_date(self):
        sti_result = self.str_to_int()
        if sti_result[0] > 0 and sti_result[0] < 32:
            pass
        else:
            raise ValueError('День выходит за диапазон 1-31')
        if sti_result[1] > 0 and sti_result[1] < 13:
            pass
        else:
            raise ValueError('Месяц выходит за диапазон 1-12')
        if sti_result[2] > 0:
            pass
        else:
            raise ValueError('Это было слишком давно...')
        return 'Дата введена корректно'

test_date = DateCheck('11-122-2020')
print(test_date.str_to_int())
try:
    # test_date.validation_date()
    print(test_date.validation_date())
except ValueError as err:
    print(f'{err}')

