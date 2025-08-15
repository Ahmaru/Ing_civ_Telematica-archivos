//
// Created by jianli-university on 26/06/25.
//

#include "Radio.h"

Radio::Radio(bool sts){
    this->status = sts;
}
void Radio::switch_Radio(bool sts){
    this->status = !sts;
}