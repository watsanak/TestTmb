# python test6.py
def simpleCipher(encrypted, k):
    decrypted = ""

    for char in encrypted:
        if char.isalpha():
            ascii_value = ord(char)
            decrypted_ascii = ((ascii_value - ord('A')) - k) % 26 + ord('A')
            decrypted += chr(decrypted_ascii)
        else:
            decrypted += char

    return decrypted

# Example
encrypted = 'VTAOG'
k = 2
decrypted = simpleCipher(encrypted, k)
print(decrypted)  # Output: TRYME