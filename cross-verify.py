import hmac
import hashlib
import binascii
from argon2 import low_level, Type

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