from std import os
from dotenv import load_dotenv, dotenv_dict, dotenv_keys, dotenv_values, get_key, set_key
from dotenv.version import __version__

def main() raises:
    _ = load_dotenv()
    # 获取某个变量
    var key = os.getenv("KEY")
    print(key)

    var dict = dotenv_dict()
    print(String(dict))

    var keys = dotenv_keys()
    print(String(keys))


    var values = dotenv_values()
    print(String(values))

    var key1 = get_key("KEY")
    print(key1)

    var value = set_key("KEY", "VALUE")
    print(value)

    print('mojo dotenv version: ', __version__)