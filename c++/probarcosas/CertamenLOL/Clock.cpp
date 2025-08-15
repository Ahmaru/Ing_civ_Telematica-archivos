#include "Clock.h"
#include <iostream>

Clock::Clock(int hrs,int mns , int scnd){
    this->hour = hrs;
    this->minute = mns;
    this->second = scnd;
}

void Clock::tick(){
    second++;
    if(this->second >= 60){
        this->minute++;
        this->second = 0;
    }
    if(this->minute >= 60){
        this->hour++;
        this->minute = 0;
    }
    if(this->hour >= 24){
        this->hour = 0;
        this->minute = 0;
        this->second = 0;
    }
}

void Clock::showTime(){
    std::cout<<"Hora actual: "<< this->hour << ":" << this->minute << ":" << this->second<<std::endl<<std::endl;
}