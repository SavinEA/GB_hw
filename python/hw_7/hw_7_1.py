class Matrix:

    def __init__(self, matrix):
        self.matrix = matrix

    def __str__(self):
        result_m = ''
        for el in self.matrix:
            for num in el:
                result_m += f'{num}\t'
            result_m += '\n'
        return f'{result_m}'

    def line_matrix(self):      # Определяем размер матрицы(строки)
        line = 0
        try:
            while True:
                self.matrix[line][0] += 0
                line += 1
        finally:
            return line

    def column_matrix(self):    # Определяем размер матрицы(столбцы)
        column = 0
        try:
            while True:
                self.matrix[0][column] += 0
                column += 1
        finally:
            return column

    def __add__(self, other):   # Суммируем матрицы произвольных размеров
        line = 0
        result = []
        if self.line_matrix() < other.line_matrix():    # Если первая матрица имеет меньше строк
            while line < self.line_matrix():
                temp = []
                column = 0
                if self.column_matrix() < other.column_matrix():                     # Если первая матрица имеет меньше столбцов
                    while column < self.column_matrix():                             # Проходим по элемнетам первой матрицы
                        el = self.matrix[line][column] + other.matrix[line][column]  # Суммируем с элементами второй матрицы
                        temp.append(el)                                              # Добавляем сумму в список
                        column += 1
                    while column < other.column_matrix():                            # Проходим по оставшимся элементам во второй матрице
                        el = other.matrix[line][column]
                        temp.append(el)                                              # Добавляем в список
                        column += 1
                    result.append(temp)                                              # Список добавляем в качестве первой строк результрующей матрицы
                else:   # Если первая матрица имеет больше столбцов, все с точностью до наоборот
                    column = 0
                    temp = []
                    while column < other.column_matrix():
                        el = self.matrix[line][column] + other.matrix[line][column]
                        temp.append(el)
                        column += 1
                    while column < self.column_matrix():
                        el = self.matrix[line][column]
                        temp.append(el)
                        column += 1
                    result.append(temp)
                line += 1
            while line < other.line_matrix():   # Дописываем оставшиеся элементы второй матрицы в последние столбцы / строки
                column = 0
                temp = []
                while column < other.column_matrix():
                    el = other.matrix[line][column]
                    temp.append(el)
                    column += 1
                result.append(temp)
                line += 1
        else:   # Если первая матрица имеет больше строк
            while line < other.line_matrix():   # Сперва идем по строкам второй матрицы
                temp = []
                column = 0
                if self.column_matrix() < other.column_matrix(): # Аналогично
                    while column < self.column_matrix():
                        el = self.matrix[line][column] + other.matrix[line][column]
                        temp.append(el)
                        column += 1
                    while column < other.column_matrix():
                        el = other.matrix[line][column]
                        temp.append(el)
                        column += 1
                    result.append(temp)
                else:
                    column = 0
                    temp = []
                    while column < other.column_matrix():
                        el = self.matrix[line][column] + other.matrix[line][column]
                        temp.append(el)
                        column += 1
                    while column < self.column_matrix():
                        el = self.matrix[line][column]
                        temp.append(el)
                        column += 1
                    result.append(temp)
                line += 1
            while line < self.line_matrix():
                column = 0
                temp = []
                while column < self.column_matrix():
                    el = self.matrix[line][column]
                    temp.append(el)
                    column += 1
                result.append(temp)
                while column < other.column_matrix():   # Оставшиеся пустые элементы заменяем на 0
                    el = 0
                    temp.append(el)
                    column += 1
                line += 1

        return Matrix(result)


m1 = [[1, 1], [2, 2], [3, 3], [4, 4]]
m2 = [[1, 1], [2, 2], [3, 3], [4, 4]]
m3 = [[5, 5, 5, 5], [5, 5, 5, 5]]


mtr1 = Matrix(m1)
mtr2 = Matrix(m2)
mtr3 = Matrix(m3)

test1 = mtr2 + mtr3 + mtr1
test2 = mtr1 + mtr2

print(test1, type(test1))
print(test2, type(test2))

