class MyException(Exception):
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def try_div(self):
        try:
            c = self.a / self.b
            print(c)
        except ZeroDivisionError as err:
            print(f'Возникла ошибка {err}')


test = MyException(10, 0)
test.try_div()