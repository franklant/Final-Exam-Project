import mysql.connector
from mysql.connector import errorcode
from DB.auth import auth_info  # authentication info for the program

# Name: Franklan Taylor
# Course: COMP267-001
# Date: 4/25/2025
# Description: Using the mysql.connector module, the program connects to the database and calls procedure from the data
# base to find and match user-credentials. This functionality is contained in a connection class for modularity.


# authenticating the program to the DB using the AUTH user info.
# if the program authenticates, it will return the DB connection
class Connection:
    cnx = None

    def __init__(self):
        pass

    def authenticate(self):
        try:
            self.cnx = mysql.connector.connect(user=auth_info['name'], password=auth_info['pass'],
                                               host="127.0.0.1", database="ncat")
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Authentication failed")
            else:
                print(f"[{err.errno}]: {err}")
        else:
            # PROGRAM to DATABASE AUTHENTICATED
            return self.cnx

    # compares user credentials with Users table and grants respective authorization if matched
    def log_in(self, user, password) -> tuple:
        fetch_cursor = self.cnx.cursor()

        # results
        args = (user, password, 0, 0)
        results = fetch_cursor.callproc("FIND_USER", args)  # cursor function to call a stored procedure

        # if the query doesn't return invalid, return the role name
        if results[2] != 'invalid':
            # the second index of results holds the OUT variable from the procedure
            return results[2], results[3], True

        # else, failed to log in
        return None, None, False

    def check_connection(self) -> bool:
        return self.cnx.is_connected()

    def get_connection(self):
        return self.cnx

