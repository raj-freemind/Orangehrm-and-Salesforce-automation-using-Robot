import random
import string
from robot.api.deco import keyword
from robot.api import logger

class CustomHelpers:
    def __init__(self):
        self.FIRST_NAMES = ['John', 'Jane', 'Michael', 'Emily', 'David', 
                           'Sophia', 'Chris', 'Olivia', 'Liam', 'Emma']
        self.MIDDLE_NAMES = ['Ray', 'Ann', 'Lee', 'Marie', 'James', 
                            'Grace', 'Alexander', 'Rose', 'Paul', 'June']
        self.LAST_NAMES = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 
                          'Garcia', 'Miller', 'Davis', 'Martinez', 'Clark']
        self.JOB = ['Accountant','Engineer','Product Manager','Business Analyst',
        'QA Engineer','DevOps Engineer','Cybersecurity Analyst','Data Scientist','HR Manager','Software Developer']

    @keyword
    def get_random_first_name(self):
        name = random.choice(self.FIRST_NAMES)
        logger.info(f"Selected first name: {name}")
        return name

    @keyword
    def get_random_middle_name(self):
        name = random.choice(self.MIDDLE_NAMES)
        logger.info(f"Selected middle name: {name}")
        return name

    @keyword
    def get_random_last_name(self):
        name = random.choice(self.LAST_NAMES)
        logger.info(f"Selected last name: {name}")
        return name
    
    @keyword
    def get_random_full_name(self):
        first = random.choice(self.FIRST_NAMES)
        middle = random.choice(self.MIDDLE_NAMES)
        last = random.choice(self.LAST_NAMES)
        full_name = f"{first} {middle} {last}"
        logger.info(f"Generated full name: {full_name}")
        return full_name
    @keyword
    def get_random_employee_id(self):
        letter = random.choice(string.ascii_uppercase)
        number = ''.join(random.choices(string.digits, k=4))
        emp_id = f"{letter}{number}"
        logger.info(f"Generated employee ID: {emp_id}")
        return emp_id
    @keyword
    def get_random_job(self):
            job = random.choice(self.JOB)
            logger.info(f"Selected first name: {job}")
            return job
    @keyword
    def should_be_string(self, value):
        if not isinstance(value, str):
            raise AssertionError(f"Expected a string but got: {type(value).__name__}")
        logger.info(f"Value is a string: {value}")