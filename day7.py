# import dataclass
from dataclasses import dataclass

with open("day7.txt", "r") as f:
    data = f.read().splitlines()


@dataclass
class File:
    name: str
    size: int


class Node:
    def __init__(self, is_dir, name, children=[], parent=None, files=[]):
        self.is_dir = is_dir
        self.name = name
        self.children = []
        self.parent = parent
        self.size = 0
        self.files = []

    def __repr__(self):
        return f"Node(name={self.name}, size={self.size})"

    def get_level(self):
        level = 0
        p = self.parent
        while p:
            level += 1
            p = p.parent
        return level

    def print_tree(self, level=0):
        # Put some underlines to show the level
        prefix = " " * level * 3 + "|__" if self.parent else ""
        print(prefix + self.name)
        for child in self.children:
            child.print_tree(level + 1)


fs = Node(is_dir=True, name="/", children=[], parent=None)

curr_node = fs
# Pula o primeiro q é o root
for line in data[1:]:
    # Se começa com "$ ls" ou "dir" ignora
    if line.startswith("$ ls") or line.startswith("dir"):
        continue

    # Se for uma mudança de diretório
    if line.startswith("$ cd"):
        dir_name = line.split(" ")[-1]
        # Confere se é "..", se sim, volta um nível
        if dir_name == "..":
            curr_node = curr_node.parent
        # Caso contrario, vamo pra baixo
        else:
            # Primeiro confere se o dir_name
            # já existe como filho
            # for child in curr_node.children:
            #     if child.name == dir_name:
            #         curr_node = child
            #         break

            # Esse else é estranho, mas ele só roda
            # se o for não encontrar nada (da break)
            # else:
            # Se não existe, cria
            n = Node(
                is_dir=True,
                name=dir_name,
            )
            curr_node.children.append(n)
            n.parent = curr_node
            curr_node = n

    # Se for um arquivo
    else:
        file_size, file_name = line.split(" ")
        # Confere se ja nao tem um file com esse nome
        existing_fnames = [f.name for f in curr_node.files]

        # Add only if not exist
        if file_name not in existing_fnames:
            file_size = int(file_size)
            f = File(name=file_name, size=file_size)
            curr_node.files.append(f)
            # ADd the size to current dir
            curr_node.size += file_size

            # Add the size to all parents
            p = curr_node.parent
            while p:
                p.size += file_size
                p = p.parent


# yolo global variable
accum = 0
# Traverse and add small sizes (<100_000) to accum
def traverse_count_small(node):
    global accum

    for child in node.children:
        traverse_count_small(child)

    if node.size <= 100_000:
        accum += node.size


traverse_count_small(fs)

print(accum)


max_fs_size = 70_000_000
curr_fs_size = fs.size
unused = max_fs_size - curr_fs_size

print(f"Max: {max_fs_size}, Current: {curr_fs_size}, Unused: {unused}")

needed_unused = 30_000_000

need_to_free = needed_unused - unused

# Now I need to go through all the dirs and find the ones
# that weight more than need_to_free.
# Afterwards I'll get the smallest one and delete it

possible_deletes = []


def traverse_find_big(node):
    global possible_deletes

    for child in node.children:
        traverse_find_big(child)

    if node.size > need_to_free:
        possible_deletes.append(node.size)


traverse_find_big(fs)

# Sort ascending
sorted_possible_deletes = sorted(possible_deletes)
print(sorted_possible_deletes[:5])
