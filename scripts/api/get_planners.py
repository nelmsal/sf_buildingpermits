
def get_planners(city='WC'):
    if city.upper() in ['WALNUT CREEK', 'WC']:
        planner_initials = {
            'ABC': 'Alan Carreon',
            'AS': 'Ana Spinola',
            'AMS': 'Andrew Smith',
            'CG': 'Chip Griffin',
            'EB': 'Ethan T Bindernagel',
            'GDK': 'Greg Kapovich',
            'GV': 'Gerardo Victoria',
            'HEC': 'Haley E Croffoot',
            'HH': 'Haley Hubbard',
            'JG': 'Jessica J Gonzalez',
            'JCav': 'Jeanine Cavalli',
            'KN': 'Ken Nodder',
            'OA': 'Ozzy Arce',
            'SKG': 'Simar Gill',
            'SP': 'Sukhamrit S Purewal',
            'TC': 'Trishia Caguiat'
        }
        planner_names = {v:k for k,v in planner_initials.items()}
        planner_names['Haley Hubbard'] = 'HEC'
        planner_initials['HH'] = 'Haley E Croffoot'

    return planner_initials

if __name__ == '__main__':
    get_planners()