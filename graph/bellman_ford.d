struct Edge(T) {
    int to;
    T cost;
}

T[] bellman_ford(T, T inf)(const Edge!(T)[][] graph, int start) {
    int n = graph.length.to!int;
    auto dist = new T[](n);
    dist[] = inf;
    dist[start] = 0;

    foreach (i; 0..n) {
        foreach (u; 0..n) {
            foreach (e; graph[u]) {
                if (dist[u] != inf && dist[e.to] > dist[u] + e.cost) {
                    dist[e.to] = dist[u] + e.cost;
                    if (i == n - 1) {
                        dist[e.to] = -inf;
                    }
                }
            }
        }
    }

    auto stack = new int[](n);
    int sp = 0;

    foreach (i; 0..n) {
        if (dist[i] == -inf) {
            stack[sp++] = i;
        }
    }

    while (sp > 0) {
        int u = stack[--sp];
        foreach (e; graph[u]) {
            if (dist[e.to] == -inf) continue;
            dist[e.to] = -inf;
            stack[sp++] = e.to;
        }
    }

    return dist;
}
