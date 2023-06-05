# python test1.py

def check_dup(list_a, list_b):
    dup = []
    for item in list_a:
        if item in list_b and item not in dup:
            dup.append(item)
    return dup

list_a = [1, 2, 3, 5, 6, 8, 9]
list_b = [3, 2, 1, 5, 6, 0]

dup_items = check_dup(list_a, list_b)
print("Duplicate items:", dup_items)
