import requests

serverPath = "http://172.0.0.1:8086"
databaseName = "mydb"
user = "root"
password = "root"

url = serverPath + "/db/" + databaseName + "/series?"

r = requests.get (url, params = {'u':user, 'p':password, 'q': 'list series'})
data = r.json()
#print data
for var in data: 
	print "Dropping " + var["name"]; requests.get (url, params = {'u':user, 'p':password, 'q': 'drop series' + var["name"]});