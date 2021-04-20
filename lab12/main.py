import redis
import json

r = redis.Redis(
    host='redis-19595.c262.us-east-1-3.ec2.cloud.redislabs.com',
    port="19595",
    password='U3J8hm4usI8dlT7pVMe8Ek90kwbv1VhA')
print(r)

# Ex 1
r.hset("Cus", "001", json.dumps({"first_name": "Jane", "last_name": "Doe"}))
r.hset("Cus", "002", json.dumps({"first_name": "John", "last_name": "Doe"}))
r.hset("Cus", "003", json.dumps({"first_name": "Jane", "last_name": "Smith"}))
r.hset("Cus", "004", json.dumps({"first_name": "John", "last_name": "Smith"}))
r.hset("Cus", "005", json.dumps({"first_name": "Jane", "last_name": "Jones"}))
r.hset("Cus", "006", json.dumps({"first_name": "John", "last_name": "Jones"}))

r.hset("Ord", "1001", json.dumps({"customer_numb": "002", "order_date": "10/10/09", "order_total": "250.85"}))
r.hset("Ord", "1002", json.dumps({"customer_numb": "002", "order_date": "2/21/10", "order_total": "125.89"}))
r.hset("Ord", "1003", json.dumps({"customer_numb": "003", "order_date": "11/15/09", "order_total": "1567.99"}))
r.hset("Ord", "1004", json.dumps({"customer_numb": "004", "order_date": "11/22/09", "order_total": "180.92"}))
r.hset("Ord", "1005", json.dumps({"customer_numb": "004", "order_date": "12/15/09", "order_total": "565.00"}))
r.hset("Ord", "1006", json.dumps({"customer_numb": "006", "order_date": "11/22/09", "order_total": "25.00"}))
r.hset("Ord", "1007", json.dumps({"customer_numb": "006", "order_date": "10/8/09", "order_total": "85.00"}))
r.hset("Ord", "1008", json.dumps({"customer_numb": "006", "order_date": "12/29/09", "order_total": "109.12"}))

print(r.hgetall("Cus"))
print(r.hgetall("Ord"))

# Ex 2
r.hset("Post", "1", json.dumps({"username": "u_name_1", "name": "name_1", "followers": ["2"], "following": ["2"], "posts": []}))
r.hset("Post", "2", json.dumps({"username": "u_name_2", "name": "name_2", "followers": ["1"], "following": ["1"], "posts": []}))

print(r.hgetall("Post"))
