import os
import pygame
import sys
from Menus.ManagerMenu import ManagerMenu
from Menus.StudentMenu import StudentMenu
from DB.connection import Connection
from UI.textbox import TextBox
from UI.buttonbox import ButtonBox

# Name: Franklan Taylor
# Course: COMP267-001
# Date: 4/25/2025
# Description: The program authenticates to the database and checks login credentials using the connection class from
# 'connection.py'. If the credentials match, you will be authorized to your respective user menu depending on your role.
# This project can be run using this main file or by running the 'FinalExamProjectApp' shortcut, starting the application

os.environ['SDL_VIDEO_CENTERED'] = '1'  # center the window on the screen
pygame.init()  # initialize the modules

window = pygame.display.set_mode((400, 400))
pygame.display.set_caption("Login")

font = pygame.font.Font('freesansbold.ttf', 32)

# initialize and position all UI elements for the login screen
boxes = []
user_box = TextBox(window, 100, 100, 200, 30, "Username")
pass_box = TextBox(window, 100, 200, 200, 30, "Password")
login_button = ButtonBox(window, 150, 300, 100, 30, "Login")
boxes.append(user_box)
boxes.append(pass_box)
boxes.append(login_button)
e: pygame.event = None

# authenticate the program to the DB and return a connection
conn = Connection()
cnx = conn.authenticate()

# initialize menus
m_menu = ManagerMenu(window, cnx)
s_menu = StudentMenu(window, cnx)

attempts = 0

# set a timer to count every second
timer_event = pygame.USEREVENT + 1
pygame.time.set_timer(timer_event, 1000)
time = False
show_message = False

# fires a button event at 69 FPS
button_event = pygame.USEREVENT + 2
pygame.time.set_timer(button_event, 1000//60)
count = 0


# grants access to the manager or student menu depending on what the log in connection returns
def login(u, p):
    role, user_id, success = conn.log_in(u, p)
    # debug
    if success:
        # show the authorized menu
        if role == "Manager":
            m_menu.show_menu()
        if role == "Student":
            s_menu.show_menu(user_id)

    return success


# render text with proper texture coordinates
failed_text = font.render('Login Failed', False, "White", "Red")
textRect = failed_text.get_rect()
textRect.center = (400 // 2, 50)

click = False

# main loop
while True:
    # print("Connected?: " + str(conn.check_connection()))

    for event in pygame.event.get():
        e = event
        # use event type
        if event.type == pygame.QUIT:
            cnx.close()  # close connection
            pygame.quit()
            sys.exit()
        elif event.type == timer_event:
            if time:
                count += 1  # start counting
        elif event.type == button_event:
            click = login_button.is_clicked()
            # log in
            if click is True:
                # pygame.time.wait(1000)
                user = user_box.get_text()
                password = pass_box.get_text()
                results = login(user, password)

                if not results:
                    # login has failed, display message
                    attempts += 1
                    time = True  # start timer
                    show_message = True

        for box in boxes:
            if type(box) is TextBox:
                box.render_text(pygame, event)

    # main loop
    window.fill("black")

    # draw assets to the screen
    for box in boxes:
        box.draw(pygame)
        box.clicked(pygame, e)

    if count == 2:  # hide the message after 2 seconds
        count = 0
        time = False
        show_message = False

    if show_message:
        window.blit(failed_text, textRect)

    if attempts >= 3:  # terminate program after 3 attempts
        cnx.close()
        pygame.quit()
        sys.exit()

    pygame.display.flip()  # update window


