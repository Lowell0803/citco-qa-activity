import requests
import random
import string

class GetUsersInJSON():
    def get_random_users(self):
        response = requests.get("https://jsonplaceholder.typicode.com/users", verify=False)
        users = response.json()

        # decorate the first 5 only
        for idx, i in enumerate(users[:10]):
            i["birthday"] = self.get_random_birthday()
            i["password"] = self.generate_password()
            i["address"]["stateAbbr"] = str(i["address"]["street"][0]) + str(i["address"]["suite"][0]) + str(i["address"]["city"][0])
        return users[:10]   # only return 5

    def get_random_birthday(self):
        return str(random.randint(1,12)).zfill(2) + str(random.randint(1,28)).zfill(2) + str(random.randint(1999,2006))

    def generate_password(self, length=8):
        chars = string.ascii_letters + string.digits + "!@#$%"
        return ''.join(random.choice(chars) for _ in range(length))

    # para mas madali nagdagdag me function
    def get_processed_users(self):
        users = self.get_random_users()
        processed = []
        for u in users:
            names = u["name"].split()
            first_name = " ".join(names[:-1]) if len(names) > 1 else names[0]
            last_name = names[-1] if len(names) > 1 else ""

            processed.append({
                "first_name": first_name,
                "last_name": last_name,
                "email": u["email"],
                "birthday": u["birthday"],
                "address": f'{u["address"]["street"]} {u["address"]["suite"]}',
                "city": u["address"]["city"],
                "state": u["address"]["stateAbbr"],
                "zipcode": u["address"]["zipcode"],
                "password": u["password"],
                "confirm_password": u["password"]
            })
        return processed
