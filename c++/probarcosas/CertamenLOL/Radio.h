//
// Created by jianli-university on 26/06/25.
//

#ifndef RADIO_H
#define RADIO_H



class Radio {
protected:
    bool status;
public:
    Radio(bool sts);
    void switch_Radio(bool sts);
};



#endif //RADIO_H
