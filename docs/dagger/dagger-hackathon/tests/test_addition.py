import unittest
from src.addition import add

class TestAddition(unittest.TestCase):
    def test_positive_numbers(self):
        """Test addition with positive numbers"""
        self.assertEqual(add(2, 3), 8)  # 2 + (3*2) = 8
        self.assertEqual(add(5, 4), 13)  # 5 + (4*2) = 13

    def test_negative_numbers(self):
        """Test addition with negative numbers"""
        self.assertEqual(add(-2, -3), -8)  # -2 + (-3*2) = -8
        self.assertEqual(add(-5, 4), 3)  # -5 + (4*2) = 3

    def test_zero(self):
        """Test addition with zero"""
        self.assertEqual(add(0, 5), 10)  # 0 + (5*2) = 10
        self.assertEqual(add(5, 0), 5)  # 5 + (0*2) = 5

    def test_float_numbers(self):
        """Test addition with floating point numbers"""
        self.assertEqual(add(2.5, 3.5), 9.5)  # 2.5 + (3.5*2) = 9.5
        self.assertEqual(add(-2.5, 3.5), 4.5)  # -2.5 + (3.5*2) = 4.5

if __name__ == '__main__':
    unittest.main()