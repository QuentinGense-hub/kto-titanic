import unittest
from dataclasses import dataclass
from typing import List


MINIMUM_LENGTH_EXCLUSIVE: int = 7


@dataclass
class FirstName:
    value: str

    def has_more_than_seven_letters(self) -> bool:
        return len(self.value) > MINIMUM_LENGTH_EXCLUSIVE


def count_first_names_longer_than_seven_letters(first_names: List[FirstName]) -> int:
    return sum(
        first_name.has_more_than_seven_letters()
        for first_name in first_names
    )


class TestCountFirstNames(unittest.TestCase):

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
