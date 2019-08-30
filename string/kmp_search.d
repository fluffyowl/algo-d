int[] kmp_search(T)(const T[] S, const T[] W) {
    int j, k;
    int[] P;
    auto table = kmp_table(W);

    while (j < S.length) {
        if (W[k] == S[j]) {
            j += 1;
            k += 1;
            if (k == W.length) {
                P ~= j - k;
                k = table[k];
            }
        } else {
            k = table[k];
            if (k < 0) {
                j += 1;
                k += 1;
            }
        }
    }

    return P;
}

int[] kmp_table(T)(const T[] W) {
    auto n = W.length.to!int;
    auto table = new int[](n+1);
    table[0] = -1;
    int pos = 1, cnd = 0;

    while (pos < n) {
        if (W[pos] == W[cnd]) {
            table[pos] = table[cnd];
        } else {
            table[pos] = cnd;
            cnd = table[cnd];
            while (cnd >= 0 && W[pos] != W[cnd]) {
                cnd = table[cnd];
            }
        }
        pos += 1;
        cnd += 1;
    }

    table[pos] = cnd;
    return table;
}
