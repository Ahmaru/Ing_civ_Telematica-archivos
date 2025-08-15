#include <iostream>
#include "RadioClock.h"
using namespace std;

int main()
{
    int hour = 11, minute = 25, second = 15;
    int a_hour = 13, a_minute = 26, a_second = 16;

    RadioClock radioAlarma(hour, minute, second, true, true);
    radioAlarma.setAlarm(a_hour, a_minute, a_second);

    while (!radioAlarma.verify_Alarm()){
        radioAlarma.tick();
        radioAlarma.showTime();
    }
    return 0;
}