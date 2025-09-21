import hmac
import hashlib
import binascii
from argon2 import low_level, Type
from binascii import unhexlify
from hkdf import hkdf_extract, hkdf_expand
from Crypto.Cipher import AES
from nacl.bindings import crypto_aead_chacha20poly1305_ietf_encrypt

# pip install argon2-cffi pynacl pycryptodome

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

def encrypt_aes256gcm_hex(hex_key: str, hex_plain_text: str, hex_nonce: str, aad: str) -> (str, str):
    key_bytes = binascii.unhexlify(hex_key)
    message_bytes = binascii.unhexlify(hex_plain_text)
    nonce_bytes = binascii.unhexlify(hex_nonce)
    aad_bytes = aad.encode('utf-8')

    cipher = AES.new(key_bytes, AES.MODE_GCM, nonce_bytes)
    cipher.update(aad_bytes)
    ed, auth_tag = cipher.encrypt_and_digest(message_bytes)
    return (binascii.hexlify(ed).decode('utf-8'), binascii.hexlify(auth_tag).decode('utf-8'))

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

def derive_hkdf(key_hex, salt_hex, info, output_length=64):
    key = binascii.unhexlify(key_hex)
    salt = binascii.unhexlify(salt_hex)
    info_bytes = info.encode('utf-8')

    prk = hkdf_extract(salt, key, hash=hashlib.sha256)
    derived_key = hkdf_expand(prk, info_bytes, output_length, hash=hashlib.sha256)

    return binascii.hexlify(derived_key).decode('utf-8')

if __name__ == "__main__":
    master_password = "313233343536" #123456
    secret_key = "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f"
    transform_seed = "b27f6e2bd596308c190c4f1d68660bc3"
    master_seed = "8a7c01c0b81c8872e016d779486bc189"
    instance_id = "WJB6W"
    symmetric_key = "8fc13f5ef75f029588dfe60f72706283bbc1e781a13f3df799c25131abb8b300adf0efe34d377c605f964bd505bf174c1f4521d6244d5e75309dc3ea115b95be"
    nonce = "2921075aed8cae8b22aae119"

    master_key = hmac_sha256_hex(master_password, secret_key)
    transformed_master_key = generate_argon2_hash_hex(master_key, transform_seed)
    strectched_master_key = derive_hkdf(transformed_master_key, master_seed, instance_id)

    encrypted_symmetric_Key, auth_tag = encrypt_aes256gcm_hex(strectched_master_key[:64], symmetric_key, nonce, instance_id)

    print(f"secret_key: {secret_key}")
    print(f"master_key: {master_key}")
    print(f"transformed_master_key: {transformed_master_key}")
    print(f"strectched_master_key: {strectched_master_key}")
    print(f"protected_symmetric_Key: {encrypted_symmetric_Key}")
    print(f"auth_tag: {auth_tag}")