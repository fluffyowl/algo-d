T[][] warshall_floyd(T, T inf)(const T[][] graph) {
    import std.conv : to;

    int n = graph.length.to!int;
    auto dist = new T[][](n, n);
    foreach (i; 0..n) foreach (j; 0..n) dist[i][j] = graph[i][j];

    foreach (i; 0..n)
        foreach (j; 0..n)
            foreach (k; 0..n)
                if (dist[j][i] != inf && dist[i][k] != inf)
                    dist[j][k] = min(dist[j][k], dist[j][i] + dist[i][k]);

    return dist;
}
