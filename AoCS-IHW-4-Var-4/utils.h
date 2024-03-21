#ifndef AOCS_IHW_4_VAR_4_UTILS_H
#define AOCS_IHW_4_VAR_4_UTILS_H

#include <iostream>

using namespace std;

template<typename T>
void requireInput(const string &prompt, T &param, T lowerBound, T upperBound) {
    param = 0;
    while (param < lowerBound || param > upperBound) {
        cout << "Enter " << prompt << " [from " << lowerBound << " to " << upperBound << "]: ";
        cin >> param;
        if (param < lowerBound || param > upperBound)
            cout << "Incorrect input out of bounds. Try again" << endl;
    }
}

template<typename T>
void requireInput2(const string &prompt, T &param1, T &param2, T lb1, T ub1, T lb2, T ub2) {
    param1 = 0;
    param2 = 0;
    while (param1 < lb1 || param1 > ub1 || param2 < lb2 || param2 > ub2) {
        cout << "Enter " << prompt << " [from " << lb1 << " to " << ub1 << " and from " << lb2 << " to " << ub2
             << "]: ";
        cin >> param1 >> param2;
        if (param1 < lb1 || param1 > ub1 || param2 < lb2 || param2 > ub2)
            cout << "Incorrect input out of bounds. Try again" << endl;
    }
}

#endif //AOCS_IHW_4_VAR_4_UTILS_H