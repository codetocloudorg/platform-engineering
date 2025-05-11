import unittest
from src.addition import add

class TestAddition(unittest.TestCase):
    def test_positive_numbers(self):
        """Test addition with positive numbers"""
        self.assertEqual(add(2, 3), 5) 

if __name__ == '__main__':
    unittest.main()