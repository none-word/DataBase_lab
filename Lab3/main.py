import psycopg2
from faker import Faker

con = psycopg2.connect(database="customers", user="postgres",
                       password="admin", host="localhost", port="5433")

print("Database opened successfully")
cur = con.cursor()
cur.execute('''CREATE TABLE CUSTOMER2
       (ID INT PRIMARY KEY     NOT NULL,
       Name           TEXT    NOT NULL,
       Address            TEXT     NOT NULL,
       Age INT NOT NULL,
       review        TEXT);''')
print("Table created successfully")
fake = Faker()
for i in range(100000):
    print(i)
    cur.execute("INSERT INTO CUSTOMER2 (ID,Name,Address,Age,review) VALUES ('"+ str(i)+"','"+fake.name()+"','"+fake.address()+"','"+str(fake.random_int(min=1, max=100))+"','"+fake.text()+"')")
    con.commit()