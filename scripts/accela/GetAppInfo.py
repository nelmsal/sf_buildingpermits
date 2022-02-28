import json

app_info_path = r'C:\Users\nelms\Documents\Code\keys\permit_metric_app.json'
user_info_path = r'C:\Users\nelms\Documents\Code\keys\accela_user_info.json'


def get_app_info(app_info_path=app_info_path, app_type='citizen'):
    f = open(app_info_path, "r")
    app_info = json.loads(f.read())[app_type]
    f.close()

    app_name, app_id, app_secret = app_info.values()

    return app_id, app_secret

def get_user_info(user_info_path=user_info_path):
    f = open(user_info_path, "r")
    user_info = json.loads(f.read())['User Info']
    f.close()

    username, password = user_info['username'], user_info['password']

    return username, password

def GetAppUserInfo(app_info_path=app_info_path, user_info_path=user_info_path, app_type = 'citizen'):
    app_id, app_secret = get_app_info(app_info_path, app_type=app_type)

    username, password = get_user_info(user_info_path)

    info_values = {
        'client_id'       : app_id,           #'635519551732860453',
        'client_secret'   : app_secret,           #'da4d29c285cf4f77b017811d86372863',
        'username'        : username,
        #'MyAccelaUser',
        'password'        : password,
    }

    return info_values