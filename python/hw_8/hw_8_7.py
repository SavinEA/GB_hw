import cmath

class KomplexNum:
    def __init__(self, a, b):
        self.a = a
        self.b = b
        self.i = cmath.sqrt(-1)
        self.z = self.a + self.b * self.i

    def __str__(self):
        return f'{self.z}'

    def __add__(self, other):
        return KomplexNum((self.a + other.a), (self.b + other.b))

    def __mul__(self, other):
        return KomplexNum((self.a * other.a - self.b * other.b), (self.a * other.b + self.b * other.a))


z1 = KomplexNum(3, 4)
z2 = KomplexNum(2, 3)
z3 = KomplexNum(2, 7)
print(z1, z2, z3)
z_add = z1 + z2 + z3
z_mull = z1 * z2 * z3
print(z_add, z_mull)
