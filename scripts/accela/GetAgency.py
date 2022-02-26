import json

def load_agencies():
    f = open(user_info_path, "r")
    user_info = json.loads(f.read())['User Info']
    f.close()

def get_agency_info(agency_name):
    f = open(user_info_path, "r")
    user_info = json.loads(f.read())['User Info']
    f.close()

    username, password = user_info['username'], user_info['password']

    return username, password