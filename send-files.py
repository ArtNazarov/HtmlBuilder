import requests
domain = "upload.artnazarov.ru"
myurl = "http://" + domain + "/bridge.php"
files = {"file": open("/home/artem/htmlbuilder-php-bridge/files.zip", "rb")}
data = {"API": "myapi333"}
res = requests.post(myurl, data=data, files=files)
print(res.text)
