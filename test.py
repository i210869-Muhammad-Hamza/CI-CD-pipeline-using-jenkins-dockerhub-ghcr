import unittest

class TestExample(unittest.TestCase):
    def test_addition(self):
        self.assertEqual(1 + 1, 2)
    def test_addition(self):
        self.assertEqual(1 + 3, 4)
    def test_addition(self):
        self.assertEqual(1 + 5, 6) 

if __name__ == '__main__':
    unittest.main()
