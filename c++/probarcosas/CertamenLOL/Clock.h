//
// Created by jianli-university on 27/06/25.
//

#ifndef CLOCK_H
#define CLOCK_H



class Clock {
public:
    Clock(int hrs,int mns,int scnd);
    void tick();
    void showTime();
protected:
    int hour, minute, second;
};



#endif //CLOCK_H
