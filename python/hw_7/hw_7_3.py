class OrganicCell:

    def __init__(self, cell):
        self.cell = cell

    def __add__(self, other):
        add_cell = self.cell + other.cell
        return OrganicCell(add_cell)

    def __sub__(self, other):
        sub_cell = self.cell - other.cell
        if sub_cell > 0:
            return OrganicCell(sub_cell)
        else:
            raise Exception('первая клетка меньше второй')

    def __mul__(self, other):
        mull_cell = self.cell * other.cell
        return OrganicCell(mull_cell)

    def __truediv__(self, other):
        div_cell = self.cell // other.cell
        return OrganicCell(div_cell)

    def make_order(self, cell_in_line):
        full_line = self.cell // cell_in_line
        i = 0
        result_cell = ''
        while i < full_line:
            result_cell += cell_in_line * '*' + '\n'
            i += 1
        result_cell += (self.cell % cell_in_line) * '*' + '\n'
        return result_cell

    def __str__(self):
        return f'{self.cell}'


c0 = OrganicCell(1200)
c1 = OrganicCell(12)
c2 = OrganicCell(10)
c3 = OrganicCell(15)

add_cell = c1 + c2 + c3
print(f'Сумма клеток: {add_cell}')

try:
    sub_cell1 = c1 - c2
    print(f'Разница клеток c1 - c2: {sub_cell1}')
    sub_cell2 = c1 - c2 - c3
    print(f'Разница клеток c1 - c2 - c3: {sub_cell2}')
except Exception as er:
    print(f'Разность не возможна по причичне: {er}')

mul_cell = c1 * c2 * c3
print(f'Произведение клеток: {mul_cell}')

div_cell = c0 / c1 / c2
print(f'Деление клеток: {div_cell}')

print(c1.make_order(6))
print(c1.make_order(5))
print(c1.make_order(4))
