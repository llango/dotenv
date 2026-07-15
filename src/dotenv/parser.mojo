from std.os import getenv, setenv
from std.pathlib import Path, cwd
from std.collections import Dict, List


def _parse_dotenv() raises -> Dict[String, String]:
    """Read and parse the .env file, returning key-value pairs as a Dict."""
    var current_dir = cwd()
    var dotenv_path = current_dir / ".env"
    var env_dict = Dict[String, String]()
    if not dotenv_path.exists():
        return env_dict^

    with open(String(dotenv_path), "r") as f:
        file = f.read()

    var lines = file.split("\n")
    for i in range(len(lines)):
        var line = lines[i]
        var stripped_line = line.strip()
        if not stripped_line.startswith("#") and stripped_line.byte_length() > 0:
            var key_value = stripped_line.split("=", 1)  # 只分割第一个等号
            if len(key_value) >= 2:
                var key = String(key_value[0].strip())
                var value_str = String(key_value[1].strip())
                # 移除引号（如果存在）
                var value_1: String
                if (value_str.startswith('"') and value_str.endswith('"')) or (value_str.startswith("'") and value_str.endswith("'")):
                    value_1 = String(value_str[byte=1: value_str.byte_length() - 1])
                else:
                    value_1 = value_str
                env_dict[key] = value_1

    return env_dict^


def load_dotenv() raises -> None:
    """
    Load the .env file from the current working directory into environment variables.
    """
    var env_dict = _parse_dotenv()
    for item in env_dict.items():
        _ = setenv(item.key, item.value, True)


def dotenv_dict() raises -> Dict[String, String]:
    """
    Return a dictionary of the key-value pairs in the .env file.
    """
    return _parse_dotenv()


def dotenv_keys() raises -> List[String]:
    """
    Return a list of the keys in the .env file.
    """
    var keys = List[String]()
    var env_dict = dotenv_dict()
    print("env_dict: ", env_dict)
    for item in env_dict.items():
        keys.append(item.key)
    return keys^


def dotenv_values() raises -> List[String]:
    """
    Return a list of the values in the .env file.
    """
    var values = List[String]()
    var env_dict = dotenv_dict()
    for item in env_dict.items():
        values.append(item.value)
    return values^


def get_key(key_name: String, default: String = "") -> String:
    """
    Get the key from the .env file or environment variables.
    """
    return getenv(key_name, default)


def set_key(key_name: String, value: String) -> Bool:
    """
    Set the key in environment variables.
    Returns True if successful, False otherwise.
    """
    return setenv(key_name, value, True)
