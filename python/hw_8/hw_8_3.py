class IntCheck(Exception):

    def check_plz(self, el):
        i = 0
        el = el.split('.')
        try:
            if el[1]:
                for num in el:
                    if num.isdigit():
                        i += 1
                if i == 2:
                    return True
                else:
                    return False
        except:
            for num in el:
                if num.isdigit():
                    return True
                else:
                    return False

    def __str__(self):
        return 'Это не число, попробуйте еще раз'


el_list = ''
result_list = []
while el_list != 'stop':
    el_list = input('Введите элемент списка: ')
    check = IntCheck(el_list)
    try:
        if check.check_plz(el_list) and el_list != 'stop':
            result_list.append(el_list)
        else:
            raise IntCheck
    except IntCheck as ic:
        print(ic)
print(f'Итоговый лист: {result_list}')
