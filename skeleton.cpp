#include <bits/stdc++.h>
#define endl '\n'

#define SZ(x) ((int)x.size())
#define ALL(V) V.begin(), V.end()

using namespace std;

template<class T, class T1> int chkmin(T &x, const T1 &y) { return x > y ? x = y, 1 : 0; }
template<class T, class T1> int chkmax(T &x, const T1 &y) { return x < y ? x = y, 1 : 0; }

template<typename T> using matrix = vector<vector<T>>;
template<typename T> using rubik = vector<vector<vector<T>>>;

template<typename T1, typename T2> ostream& operator<<(ostream& out, const pair<T1, T2>& x) { return out << x.first << ' ' << x.second; }
template<typename T1, typename T2> istream& operator>>(istream& in, pair<T1, T2>& x) { return in >> x.first >> x.second; }
template<typename T> istream& operator>>(istream& in, vector<T>& a) { for(auto &x : a) in >> x; return in; };
template<typename T> ostream& operator<<(ostream& out, vector<T>& a) { for(auto &x : a) out << x << ' '; return out; };

const int MAXN = (1 << 20);

void read() {

}

void solve() {

}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);

    int T = 1;
    //cin >> T;
    for(int test = 1; test <= T; test++) {
        read();
        //cout << "Case #" << test << ": ";
        solve();
    }

    return 0;
}
