import json

agency_path = r".\static_data\agencies.json"

def get_agencies(agency_path = agency_path):
    with open(agency_path, 'r') as ajson:
        agencies = ajson.read()
        agencies = json.loads(agencies)['agency']
    return agencies

def get_agencies_accela_info(city, get='dict', agency_path = agency_path):

    nicknames = {
        'SF':'CCSF',
        'BERK':'BERKELEY',
        'OAK':'OAKLAND'
    }
    city = city.strip().upper()
    if city in nicknames.keys():
        city = nicknames[city]

    agencies_info = get_agencies(agency_path)
    city_info = agencies_info[city]
    if get =='values':
        return city_info['agency'], city_info['environment']
    elif get == 'both':
        return city_info, city_info['agency'], city_info['environment']
    else:
        return city_info