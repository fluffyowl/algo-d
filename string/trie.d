// manually verified on: https://atcoder.jp/contests/code-festival-2016-qualb/tasks/codefestival_2016_qualB_e

class Trie(T) {

    class Node {
        Edge[] edges;
        bool terminal;

        this(bool terminal) {
            this.terminal = terminal;
        }
    }

    class Edge {
        Node to;
        T label;

        this(Node to, T label) {
            this.to = to;
            this.label = label;
        }
    }

    Node root;

    this() {
        root = new Node(false);
    }

    bool lookup(T str) {
        return lookup(root, str);
    }

    private bool lookup(Node node, T str) {
        if (node.terminal && str.empty) return true;
        foreach (e; node.edges) {
            if (str.startsWith(e.label)) {
                return lookup(e.to, str[e.label.length..$]);
            }
        }
        return false;
    }

    void insert(T str) {
        if (lookup(str)) return;
        insert(root, str);
    }

    private void insert(Node node, T str) {
        if (str.empty) {
            node.edges ~= new Edge(new Node(true), str);
            return;
        }
        foreach (e; node.edges) {
            int common_prefix = -1;
            foreach (i; 0..min(e.label.length, str.length)) {
                if (e.label[i] != str[i]) break;
                common_prefix = i.to!int;
            }
            if (common_prefix == -1) continue;
            if (common_prefix + 1 == e.label.length) {
                insert(e.to, str[e.label.length..$]);
                return;
            }
            auto new_node = new Node(false);
            auto new_label = e.label[common_prefix+1..$].dup.to!T;
            new_node.edges = [new Edge(e.to, new_label)];
            e.to = new_node;
            e.label = e.label[0..common_prefix+1].dup;
            insert(new_node, str[common_prefix+1..$]);
            return;
        }
        auto new_node = new Node(false);
        node.edges ~= new Edge(new_node, str);
        insert(new_node, str[$..$]);
    }
}
