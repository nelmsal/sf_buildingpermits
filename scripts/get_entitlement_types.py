DATA_DIR = r'./clean_data/'

def get_entitlement_types(city='WC'):
    import pandas as pd
    import os

    if city.upper().strip() in ['WALNUT CREEK', 'WC']:
        ent_name = 'WC_entitlements.csv'
    
    ent_path = os.path.join(DATA_DIR, ent_name)
    entitlements = pd.read_csv(ent_path)
    entitlements.fillna(value='Other', inplace=True)

    entitlements = entitlements.set_index('full_name')['short'].to_dict()

    #entitlements = {v:k for k,v in entitlements.items()}
    #entitlements['Other'] = 'Other'
    return entitlements

if __name__ == '__main__':
    entitlements = get_entitlement_types()