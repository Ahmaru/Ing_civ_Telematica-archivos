#include "RadioClock.h"

RadioClock::RadioClock(int h , int m, int s, bool one , bool two) : Radio(one) , Clock(h,m,s){};

void RadioClock::setAlarm(int pHour, int pMinute, int pSecond){
    this->a_hour = pHour;
    this->a_minute = pMinute;
    this->a_second = pSecond;
}

void RadioClock::activate_Alarm(){
    if(this->a_status == false){
        switch_Radio(this->a_status);
    }
    for(int i = 0 ; i < 20 ; i++){
        std::cout<<"BEEP nigga BEEP";
    }

}

void RadioClock::switch_Alarm(){
    this->a_status = !this->a_status;
}

bool RadioClock::verify_Alarm(){
    if(hour == a_hour && minute == a_minute && second == a_second){
        activate_Alarm();
        switch_Alarm();
        return true;
    }
    return false;
}
