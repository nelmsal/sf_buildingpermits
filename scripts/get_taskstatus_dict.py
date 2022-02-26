def get_taskstatus_dict(city='WC'):
    if type(city) in [set, tuple, list]:
        dept = city[1]
        city = city[0]
    else:
        dept = 'Planning'

    if city.upper().strip() in ['WALNUT CREEK', 'WC']:
        TaskStatus = {
            'Building':{
                'Application Submittal - Route':'Start',
                'Consolidated Comments - With Customer for Response':'Round_End',
                'Resubmittal or Revision - Route':'Round_Start',
                #'Building Review - Notes':'Pause',
                'Ready to Issue - Conditionally Approved':'End',
                'Ready to Issue - Issued':'End',
                'Ready to Issue - Approved':'End'
            },
            'Site Development Permit':{
                'Status - Received':'Start',
                'Application Submittal - Route':'Start',
                'Consolidated Comments - With Customer for Response':'Round_End',
                'Consolidated Comments - Resubmittal':'Round_Start',
                #'Consolidated Comments - Ready to Issue': 'Round_Start',
                #'Status - Approved':'End'
                'Ready to Issue - Issue':'End'
                #'Application Submittal - Ready to Issue':'End'
            },
            'Planning':{
                'Status - Received':'Start',
                'Intake Review - Application Accepted':'Start',
                'Consolidated Comments - Deemed Incomplete':'Round_End',
                'Resubmittal - Route for Review':'Round_Start',
                'Consolidated Comments - Deemed Complete':'End',
                'Close Out - Approved':'End',
                'Staff Analysis - Set for Hearing':'End',
                'Staff Analysis - Staff Level Decision':'End',
                'Close Out - Not Approved - Closed':'End'
            }}
        TaskStatus = TaskStatus[dept]
        #All_TaskStatus = []
        #[
        #    All_TaskStatus.extend(list(TSD.keys())) for dept,TSD in TaskStatus.items()
        #]
        #All_TaskStatus = set(All_TaskStatus)
    return TaskStatus

if __name__ == '__main__':
    TaskStatus = get_taskstatus_dict()