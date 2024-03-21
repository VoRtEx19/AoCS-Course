// C++ code to implement the above approach
#include <bits/stdc++.h>
using namespace std;

double calculatePI(int prec)
{
	double prev = 1, PI = 3, n = 2, sign = 1;

	while (prec <= 0 ? abs((PI - prev) / prev) >= 0.0005 : abs(PI - prev) >= pow(10, -prec-1)) {
        prev = PI;
		PI = PI + (sign * (4 / ((n) * (n + 1)
								* (n + 2))));
		sign = sign * (-1);
		n += 2;
	}
	return PI;
}

// Driver code
int main()
{
    cout << "Enter precision: ";
    int n;
    cin >> n;
	cout << fixed << setprecision(16)
		<< "\nThe approximation of Pi is "
		<< calculatePI(n) << endl;
	return 0;
}
