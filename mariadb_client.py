from contextlib import contextmanager

import mariadb


@contextmanager
def connect(user: str, password: str, host: str, port: int, database: str):
    conn = mariadb.connect(
        user=user, password=password, host=host, port=port, database=database
    )
    try:
        yield conn.cursor()
    finally:
        conn.commit()
        conn.close()
