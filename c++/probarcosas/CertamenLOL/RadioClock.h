#include "Radio.h"
#include "Clock.h"
#include <iostream>

#ifndef RADIOCLOCK_H
#define RADIOCLOCK_H

class RadioClock : public Radio , public Clock{
protected:
    bool a_status;
    int a_hour,a_minute,a_second;
public:
void setAlarm(int pHour, int pMinute, int pSecond);
    RadioClock(int h , int m, int s, bool one , bool two);
    void switch_Alarm();
    bool verify_Alarm();
    void activate_Alarm();
};

#endif //RADIOCLOCK_H
