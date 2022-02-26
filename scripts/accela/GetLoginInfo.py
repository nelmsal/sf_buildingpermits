import json

def get_app_info(app_info_path):
    f = open(app_info_path, "r")
    app_info = json.loads(f.read())['App Info']
    f.close()


    app_name, app_id, app_secret = app_info.values()
    #print(f'App Name: {app_name}')

    return app_id, app_secret