import json

def get_user_info(user_info_path):
    f = open(user_info_path, "r")
    user_info = json.loads(f.read())['User Info']
    f.close()

    username, password = user_info['username'], user_info['password']

    return username, password