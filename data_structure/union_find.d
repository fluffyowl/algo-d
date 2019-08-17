class UnionFind {
    import std.algorithm : swap;

    int n;
    int[] table;

    this(int n) {
        this.n = n;
        table = new int[](n);
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

    bool same(int x, int y) {
        return find(x) == find(y);
    }
}
