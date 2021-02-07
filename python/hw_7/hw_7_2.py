class Cloth:

    def __init__(self, cloth_type, cloth_size):
        self.cloth_type = cloth_type
        self.cloth_size = cloth_size

    @property
    def consumption(self):
        if self.cloth_type == 'пальто':
            return f'Необходимое количество ткани на {self.cloth_type} = {self.cloth_size / 6.5 + 0.5}'
        elif self.cloth_type == 'костюм':
            return f'Необходимое количество ткани на {self.cloth_type} = {self.cloth_size * 2 + 0.5}'
        else:
            return f'Вы указали не известный тип одежды'


costume = Cloth('костюм', 175)
coat = Cloth('пальто', 48)

print(costume.consumption)
print(coat.consumption)
