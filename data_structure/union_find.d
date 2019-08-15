class UnionFind {
    import std.algorithm;

    int N;
    int[] table;

    this(int n) {
        N = n;
        table = new int[](N);
        table[] = -1;
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
    }
}
