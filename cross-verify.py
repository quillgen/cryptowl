import hmac
import hashlib
import binascii
from argon2 import low_level, Type
# pip install argon2-cffi pynacl

import binascii
from nacl.bindings import crypto_aead_chacha20poly1305_ietf_encrypt

# Input data
data = b"hello world!"
key = binascii.unhexlify("3f09ea13ceffb8e867a4af3ab17854f9f5f152591653c737a8962b94356e2c0f")
nonce = binascii.unhexlify("b27f6e2bd596308c190c4f1d")
aad = b"41964e60-5fc3-472c-8b87-71363c71b03c"

# Encrypt using ChaCha20-Poly1305
ciphertext = crypto_aead_chacha20poly1305_ietf_encrypt(
    data, 
    aad, 
    nonce, 
    key
)

# Extract ciphertext and authentication tag
# Last 16 bytes are the authentication tag
auth_tag = ciphertext[-16:]
encrypted_data = ciphertext[:-16]

print(f"Ciphertext: {binascii.hexlify(encrypted_data).decode()}")
print(f"Authentication Tag: {binascii.hexlify(auth_tag).decode()}")
print(f"Combined (ciphertext + tag): {binascii.hexlify(ciphertext).decode()}")

import hmac
import hashlib
from binascii import hexlify

# Your provided parameters
key = bytes.fromhex("509f825b859521f72fe511d2c120f53ed52bf641932d92ba086b89be3d65153a")
salt = bytes.fromhex("b27f6e2bd596308c190c4f1d68660bc3")
info = "41964e60-5fc3-472c-8b87-71363c71b03c".encode('utf-8')

# Combine salt and info to form the message
message =  salt + info

# Calculate HMAC-SHA256
hmac_result = hmac.new(key, message, hashlib.sha256).digest()

# Convert to hexadecimal string
hmac_hex = hexlify(hmac_result)

print(f"HMAC-SHA256 Result=>: {hmac_hex}")

def hmac_sha256_hex(hex_key: str, hex_message: str) -> str:
    key_bytes = binascii.unhexlify(hex_key)
    message_bytes = binascii.unhexlify(hex_message)
    
    digest = hmac.new(
        key_bytes,
        message_bytes,
        hashlib.sha256
    ).digest()
    
    return binascii.hexlify(digest).decode('utf-8')


def generate_argon2_hash_hex(hex_password: str, hex_salt: str) -> str:
    password_bytes = binascii.unhexlify(hex_password)
    salt_bytes = binascii.unhexlify(hex_salt)
    
    raw_key = low_level.hash_secret_raw(
        secret=password_bytes,
        salt=salt_bytes,
        time_cost=2,        # t=2
        memory_cost=19456,  # m=19456 (KB)
        parallelism=1,      # p=1
        hash_len=32,        # 32字节 = 256位
        type=Type.ID        # argon2id
    )
    
    return binascii.hexlify(raw_key).decode('utf-8')

if __name__ == "__main__":
    hex_key = "313233343536" #123456
    hex_message = "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f"
    hex_salt = "b27f6e2bd596308c190c4f1d68660bc3"

    hash1 = hmac_sha256_hex(hex_key, hex_message)
    master_key = generate_argon2_hash_hex(hash1, hex_salt)
    print(f"HMAC-SHA256 (hex): {hash1}")
    print(f"MasterKey (hex): {master_key}")