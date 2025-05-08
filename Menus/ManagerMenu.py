import pygame
import mysql.connector
import pygame_menu as pm

# Name: Franklan Taylor
# Course: COMP267-001
# Date: 4/25/2025
# Description: This program holds all the user functionality of the Manager role. Using the connection from the database
# the program uses procedures to complete manager tasks. 'pygame_menu' provides UI options to display the menu


class ManagerMenu:
    width = 600 * 2
    height = 400 * 2
    window: pygame.Surface
    cnx: mysql.connector.connection.MySQLConnectionAbstract

    def __init__(self, window: pygame.Surface, connection: mysql.connector.connection.MySQLConnectionAbstract):
        self.window = window
        self.cnx = connection

    def show_menu(self):
        pygame.display.set_caption("Manager Menu")
        pygame.display.set_mode([self.width, self.height])

        # Create main menu
        manager_menu = pm.Menu(
            title="Manager",
            width=self.width,
            height=self.height,
        )

        content_frame = manager_menu.add.frame_v(
            self.width - 100,
            self.height - 200,
            'content',
            background_color=(152, 160, 152),
            padding=0,
        )
        content_title = manager_menu.add.frame_h(
            self.width - 100, 52,
            background_color=(180, 180, 180),
            padding=0,
        )
        content_frame.pack(content_title)

        log_out_button = manager_menu.add.button(
            "logout",
            action=pm.events.EXIT,
            font_color='white',
            background_color='red',
            selection_color=(140, 40, 40),
        )
        content_title.pack(
            manager_menu.add.label(
                'manager_view',
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )
        content_title.pack(log_out_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        """
        CREATING BUTTONS FOR THE MENU
        """
        add_student_button = manager_menu.add.button(
            "Add Student",
            action=self.add_student_menu,
            background_color=(92, 94, 92),
            font_color="white",
            selection_color="yellow"
        )
        content_frame.pack(add_student_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        add_to_class_button = manager_menu.add.button(
            "Add Student to Class",
            action=self.add_student_to_roster_menu,
            background_color=(92, 94, 92),
            font_color="white",
            selection_color="yellow"
        )
        content_frame.pack(add_to_class_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        drop_from_class_button = manager_menu.add.button(
            "Drop Student from Class",
            action=self.drop_student_from_roster_menu,
            background_color=(92, 94, 92),
            font_color="white",
            selection_color="yellow"
        )
        content_frame.pack(drop_from_class_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        view_class_roster_button = manager_menu.add.button(
            "View Class Roster",
            action=self.view_class_roster_menu,
            background_color=(92, 94, 92),
            font_color="white",
            selection_color="yellow"
        )
        content_frame.pack(view_class_roster_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        view_student_schedule_button = manager_menu.add.button(
            "View Student Schedule",
            action=self.view_student_schedule_menu,
            background_color=(92, 94, 92),
            font_color="white",
            selection_color="yellow"
        )
        content_frame.pack(view_student_schedule_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        manager_menu.mainloop(self.window)

    """
    METHODS CREATING THE SUBMENUS AND FUNCTIONALITY
    """
    def add_student_menu(self):
        # collect class names for the selector
        cursor = self.cnx.cursor(buffered=True)
        cursor.callproc("MAJOR_NAMES")
        results = cursor.stored_results()
        items = []
        for item in results:
            items = item.fetchall()

        student_roster_menu = pm.menu.Menu(
            "Add Student",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_BLUE
        )

        content_frame = student_roster_menu.add.frame_v(
            self.width - 100,
            self.height - 200,
            background_color=(186, 194, 231),
            padding=0,
            align=pm.locals.ALIGN_CENTER,
        )
        content_title = student_roster_menu.add.frame_h(
            self.width - 100, 52,
            background_color=(180, 180, 180),
            padding=0,
        )
        content_frame.pack(content_title)

        back_button = student_roster_menu.add.button(
            "Back",
            action=lambda: self.show_menu(),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_title.pack(
            student_roster_menu.add.label(
                'add_student',
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )

        content_title.pack(back_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        # add action function that submits a procedure
        # create a lambda function that takes the first and last name and the ID from the selected class
        fname_entry = student_roster_menu.add.text_input(
            "First Name: ",
            font_color='grey',
            selection_color='white',
            background_color=(63, 91, 229)
        )
        lname_entry = student_roster_menu.add.text_input(
            "Last Name: ",
            font_color='grey',
            selection_color='white',
            background_color=(63, 91, 229)
        )

        pass_entry = student_roster_menu.add.text_input(
            "Password: ",
            font_color='grey',
            selection_color='white',
            background_color=(63, 91, 229)
        )

        selector = student_roster_menu.add.selector(
            'Major: ',
            items=items,
            style=pm.widgets.SELECTOR_STYLE_FANCY
        )
        add_button = student_roster_menu.add.button(
            "Add",
            action=lambda: self.add_student(
                selector.get_value()[0][1],
                fname_entry.get_value(),
                lname_entry.get_value(),
                pass_entry.get_value()
            ),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_frame.relax(True)

        content_frame.pack(fname_entry, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(lname_entry, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(pass_entry, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(selector, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(add_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        student_roster_menu.mainloop(self.window)

    def add_student(self, selected_major: int, f_name: str, l_name: str, password: str):
        user = f_name[0] + l_name
        cursor = self.cnx.cursor(buffered=True)
        args = (user, password, f_name, l_name, selected_major)

        results = cursor.callproc("ADD_STUDENT", args)
        self.cnx.commit()  # don't forget to commit dawg

    def add_student_to_roster_menu(self):
        # collect class names for the selector
        cursor = self.cnx.cursor(buffered=True)
        cursor.callproc("CLASS_NAMES")
        results = cursor.stored_results()
        items = []
        for item in results:
            items = item.fetchall()

        student_roster_menu = pm.menu.Menu(
            "Add Student to Class",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_BLUE
        )

        content_frame = student_roster_menu.add.frame_v(
            self.width - 100,
            self.height - 200,
            background_color=(186, 194, 231),
            padding=0,
            align=pm.locals.ALIGN_CENTER,
        )
        content_title = student_roster_menu.add.frame_h(
            self.width - 100, 52,
            background_color=(180, 180, 180),
            padding=0,
        )
        content_frame.pack(content_title)

        back_button = student_roster_menu.add.button(
            "Back",
            action=lambda: self.show_menu(),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_title.pack(
            student_roster_menu.add.label(
                'add_student_to_class',
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )

        content_title.pack(back_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        # add action function that submits a procedure
        # create a lambda function that takes the first and last name and the ID from the selected class
        fname_entry = student_roster_menu.add.text_input(
            "First Name: ",
            font_color='grey',
            selection_color='white',
            background_color=(63, 91, 229)
        )
        lname_entry = student_roster_menu.add.text_input(
            "Last Name: ",
            font_color='grey',
            selection_color='white',
            background_color=(63, 91, 229)
        )

        selector = student_roster_menu.add.selector(
            'Class: ',
            items=items,
            style=pm.widgets.SELECTOR_STYLE_FANCY
        )

        add_button = student_roster_menu.add.button(
            "Add",
            action=lambda:
            self.add_student_to_class(
                selector.get_value()[0][1],
                fname_entry.get_value(),
                lname_entry.get_value()
            ),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_frame.relax(True)

        content_frame.pack(fname_entry, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(lname_entry, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(selector, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(add_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        student_roster_menu.mainloop(self.window)

    def add_student_to_class(self, selected_class: int, f_name: str, l_name: str):
        cursor = self.cnx.cursor(buffered=True)
        args = (f_name, l_name, selected_class, 0)

        results = cursor.callproc("ADD_STUDENT_TO_ROSTER", args)
        print(results[3])
        self.cnx.commit() # don't forget to commit dawg

    def drop_student_from_roster_menu(self):
        # collect class names for the selector
        cursor = self.cnx.cursor(buffered=True)
        cursor.callproc("CLASS_NAMES")
        results = cursor.stored_results()
        items = []
        for item in results:
            items = item.fetchall()

        student_roster_menu = pm.menu.Menu(
            "Drop Student from Class",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_BLUE
        )

        content_frame = student_roster_menu.add.frame_v(
            self.width - 100,
            self.height - 200,
            background_color=(186, 194, 231),
            padding=0,
            align=pm.locals.ALIGN_CENTER,
        )
        content_title = student_roster_menu.add.frame_h(
            self.width - 100, 52,
            background_color=(180, 180, 180),
            padding=0,
        )
        content_frame.pack(content_title)

        back_button = student_roster_menu.add.button(
            "Back",
            action=lambda: self.show_menu(),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_title.pack(
            student_roster_menu.add.label(
                'drop_student_from_class',
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )

        content_title.pack(back_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        # add action function that submits a procedure
        # create a lambda function that takes the first and last name and the ID from the selected class
        fname_entry = student_roster_menu.add.text_input(
            "First Name: ",
            font_color='grey',
            selection_color='white',
            background_color=(63, 91, 229)
        )
        lname_entry = student_roster_menu.add.text_input(
            "Last Name: ",
            font_color='grey',
            selection_color='white',
            background_color=(63, 91, 229)
        )

        selector = student_roster_menu.add.selector(
            'Class: ',
            items=items,
            style=pm.widgets.SELECTOR_STYLE_FANCY
        )

        drop_button = student_roster_menu.add.button(
            "Drop",
            action=lambda:
            self.drop_student_from_class(
                selector.get_value()[0][1],
                fname_entry.get_value(),
                lname_entry.get_value()
            ),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_frame.relax(True)

        content_frame.pack(fname_entry, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(lname_entry, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(selector, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(10, 10))
        content_frame.pack(drop_button, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        student_roster_menu.mainloop(self.window)

    def drop_student_from_class(self, selected_class: int, f_name: str, l_name: str):
        cursor = self.cnx.cursor(buffered=True)
        args = (f_name, l_name, selected_class, 0)

        results = cursor.callproc("DROP_STUDENT_FROM_ROSTER", args)
        print(results[3])
        self.cnx.commit() # don't forget to commit dawg

    def view_class_roster_menu(self):
        # collect class names for the selector
        cursor = self.cnx.cursor(buffered=True)
        cursor.callproc("CLASS_NAMES")
        results = cursor.stored_results()
        items = []
        for item in results:
            items = item.fetchall()

        student_roster_menu = pm.menu.Menu(
            "View Class Roster",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_BLUE
        )

        content_frame = student_roster_menu.add.frame_v(
            self.width - 100,
            800,
            frame_id='content',
            max_height=self.height - 100,
            background_color=(186, 194, 231),
            padding=0,
            align=pm.locals.ALIGN_CENTER,
        )
        content_title = student_roster_menu.add.frame_h(
            self.width - 100, 52,
            background_color=(180, 180, 180),
            padding=0,
        )
        content_frame.pack(content_title)

        back_button = student_roster_menu.add.button(
            "Back",
            action=lambda: self.show_menu(),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_title.pack(
            student_roster_menu.add.label(
                'view_class_roster',
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )

        content_title.pack(back_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        # add action function that submits a procedure
        # create a lambda function that takes the first and last name and the ID from the selected class
        selector = student_roster_menu.add.selector(
            'Class: ',
            items=items,
            style=pm.widgets.SELECTOR_STYLE_FANCY
        )

        show_button = student_roster_menu.add.button(
            "Show",
            action=lambda: self.show_roster(
                student_roster_menu,
                show_content_frame,
                selector.get_value()[0]
            ),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        show_content_frame = student_roster_menu.add.frame_v(
            self.width - 300,
            self.height - 200,
            'show_roster',
            background_color='black',
            padding=0,
            align=pm.locals.ALIGN_CENTER
        )

        frame_title = student_roster_menu.add.frame_h(
            self.width - 300, 60, background_color=(180, 180, 180),
            frame_id='frame_title',
            padding=0
        )

        frame_title.pack(
            student_roster_menu.add.label(
                'View',
                font_color='black',
                label_id='title',
                padding=0
            ),
            margin=(10, 10)
        )
        show_content_frame.pack(frame_title)

        content_frame.relax(True)
        content_frame.pack(show_button, pm.locals.ALIGN_CENTER, margin=(10, 10))
        content_frame.pack(selector, pm.locals.ALIGN_CENTER, margin=(10, 10))
        content_frame.pack(show_content_frame, pm.locals.ALIGN_CENTER, margin=(0, 10))

        student_roster_menu.mainloop(self.window)

    def show_roster(self, roster_menu, frame, roster):
        # using the current roster id, show a list of all the classes using a for loop
        for widget in frame.get_widgets(True, True, False):
            if "title" in widget.get_id():
                roster_menu.remove_widget(widget)
            if "class" in widget.get_id():
                roster_menu.remove_widget(widget)

        frame_title = roster_menu.add.frame_h(
            self.width - 300, 60,
            font_color='black',
            background_color=(180, 180, 180),
            frame_id='frame_title',
            padding=0
        )

        frame_title.pack(
            roster_menu.add.label(
                f'View: {roster[0]}',
                font_color='black',
                padding=0,
                label_id='title'
            ),
            margin=(10, 10)
        )

        frame.pack(frame_title)

        cursor = self.cnx.cursor(buffered=True)
        args = [roster[1]]

        cursor.callproc("VIEW_CLASS_ROSTER", args)
        items = []
        results = cursor.stored_results()
        for item in results:
            items = item.fetchall()

        i = 0
        for item in items:
            i += 1
            label_title = f'{i}) {item[1]} {item[2]} | {item[3]} | ID: {item[0]}'
            button = roster_menu.add.label(
                label_title,
                label_id=f'class{str(i)}',
                font_color='white',
                background_color="black"
            )
            frame.pack(button, pm.locals.ALIGN_CENTER, margin=(0, 10))

    def view_student_schedule_menu(self):
        # collect class names for the selector
        cursor = self.cnx.cursor(buffered=True)
        cursor.callproc("STUDENT_NAMES")
        results = cursor.stored_results()
        items = []
        for item in results:
            items = item.fetchall()

        student_roster_menu = pm.menu.Menu(
            "View Student Schedule",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_BLUE
        )

        content_frame = student_roster_menu.add.frame_v(
            self.width - 100,
            800,
            frame_id='content',
            max_height=self.height - 100,
            background_color=(186, 194, 231),
            padding=0,
            align=pm.locals.ALIGN_CENTER,
        )
        content_title = student_roster_menu.add.frame_h(
            self.width - 100, 52,
            background_color=(180, 180, 180),
            padding=0,
        )
        content_frame.pack(content_title)

        back_button = student_roster_menu.add.button(
            "Back",
            action=lambda: self.show_menu(),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_title.pack(
            student_roster_menu.add.label(
                'view_student_schedule',
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )

        content_title.pack(back_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        # add action function that submits a procedure
        # create a lambda function that takes the first and last name and the ID from the selected class
        selector = student_roster_menu.add.selector(
            'Student: ',
            items=items,
            style=pm.widgets.SELECTOR_STYLE_FANCY
        )

        show_button = student_roster_menu.add.button(
            "Show",
            action=lambda: self.view_student_schedule(
                        student_roster_menu,
                        show_content_frame,
                        selector.get_value()[0][0],
                        selector.get_value()[0][1]
            ),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        show_content_frame = student_roster_menu.add.frame_v(
            self.width - 300,
            self.height - 200,
            'show_roster',
            background_color='black',
            padding=0,
            align=pm.locals.ALIGN_CENTER
        )

        frame_title = student_roster_menu.add.frame_h(
            self.width - 300, 60, background_color=(180, 180, 180),
            frame_id='frame_title',
            padding=0
        )

        frame_title.pack(
            student_roster_menu.add.label(
                'View',
                font_color='black',
                label_id='title',
                padding=0
            ),
            margin=(10, 10)
        )
        show_content_frame.pack(frame_title)

        content_frame.relax(True)
        content_frame.pack(show_button, pm.locals.ALIGN_CENTER, margin=(10, 10))
        content_frame.pack(selector, pm.locals.ALIGN_CENTER, margin=(10, 10))
        content_frame.pack(show_content_frame, pm.locals.ALIGN_CENTER, margin=(0, 10))

        student_roster_menu.mainloop(self.window)

    def view_student_schedule(self, roster_menu, frame, name, student_id):
        # using the current roster id, show a list of all the classes using a for loop
        for widget in frame.get_widgets(True, True, False):
            if "title" in widget.get_id():
                roster_menu.remove_widget(widget)
            if "class" in widget.get_id():
                roster_menu.remove_widget(widget)

        view_name = f'{name.lower().replace(" ", "_")}_view'
        frame_title = roster_menu.add.frame_h(
            self.width - 300, 60,
            font_color='black',
            background_color=(180, 180, 180),
            frame_id='frame_title',
            padding=0
        )

        frame_title.pack(
            roster_menu.add.label(
                f'View: {name}',
                font_color='black',
                padding=0,
                label_id="title"
            ),
            margin=(10, 10)
        )
        frame.pack(frame_title)

        cursor = self.cnx.cursor(buffered=True)
        args = [student_id, view_name]

        cursor.callproc("VIEW_STUDENT_SCHEDULE", args)
        items = []
        results = cursor.stored_results()
        for item in results:
            items = item.fetchall()

        i = 0
        for item in items:
            i += 1
            label_title = f'{i}) {item[1]} | {item[0]}'
            button = roster_menu.add.label(
                label_title,
                label_id=f'class{str(i)}',
                font_color='white',
                background_color="black"
            )

            frame.pack(button, pm.locals.ALIGN_CENTER, margin=(0, 10))

