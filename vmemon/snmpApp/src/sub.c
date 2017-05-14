#include <registryFunction.h>
#include <subRecord.h>
#include <menuFtype.h>
#include <dbDefs.h>
#include <errlog.h>
#include <epicsExport.h>

long
CalcAlarm(subRecord *prec) {
    int noAlarmCount = 0;
    int minorAlarmCount = 0;
    int majorAlarmCount = 0;
    int invalidAlarmCount = 0;
    double* pvalue = &prec->a;
    int i = 0;
    for (i = 0; i <= 7; i++, pvalue++) {
        if(*pvalue == 0)
            noAlarmCount += 1;
        else if(*pvalue == 1)
            minorAlarmCount += 1;
        else if(*pvalue == 2)
            majorAlarmCount += 1;
        else if(*pvalue == 3)
            invalidAlarmCount += 1;
    }

    if(majorAlarmCount >= 2)
        prec->val = 2;
    else if(minorAlarmCount >= 2)
        prec->val = 1;
    else if(invalidAlarmCount >=2)
        prec->val = 3;
    else if(noAlarmCount >= 7)
        prec->val = 0;

    return 0;
}

static registryFunctionRef subRef[] = {
    {"CalcAlarm", (REGISTRYFUNCTION) CalcAlarm},
};

static
void subRegistrar(void) {
    registryFunctionRefAdd(subRef, NELEMENTS(subRef));
}

epicsExportRegistrar(subRegistrar);
