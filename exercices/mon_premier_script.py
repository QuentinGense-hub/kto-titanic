import unittest
from dataclasses import dataclass
from typing import List


MINIMUM_LENGTH_EXCLUSIVE: int = 7 #Suppression du nombre magique


@dataclass
class FirstName:
    value: str

    def has_more_than_seven_letters(self) -> bool: #Encapsulation métier
        return len(self.value) > MINIMUM_LENGTH_EXCLUSIVE


def count_first_names_longer_than_seven_letters(first_names: List[FirstName]) -> int: #Typage complet
    long_first_names_count: int = 0

    for first_name in first_names:
        if first_name.has_more_than_seven_letters():
            long_first_names_count += 1

    return long_first_names_count


class TestCountFirstNames(unittest.TestCase): #Test lisible

    def test_should_count_first_names_longer_than_seven_letters(self) -> None:
        first_names: List[FirstName] = [
            FirstName("Guillaume"),
            FirstName("Gilles"),
            FirstName("Juliette"),
            FirstName("Antoine"),
            FirstName("François"),
            FirstName("Cassandre"),
        ]

        result: int = count_first_names_longer_than_seven_letters(first_names)

        self.assertEqual(result, 4)


if __name__ == "__main__":
    unittest.main()
