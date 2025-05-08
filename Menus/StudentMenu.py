import mysql.connector.connection
import pygame
import pygame_menu as pm

# Name: Franklan Taylor
# Course: COMP267-001
# Date: 4/25/2025
# Description: This program holds all the user functionality of the Student role. Using the connection from the database
# the program uses procedures to complete student tasks. 'pygame_menu' provides UI options to display the menu


class StudentMenu:
    window: pygame.Surface
    width = 600 * 2
    height = 400 * 2
    cnx: mysql.connector.connection.MySQLConnectionAbstract
    id = 0

    def __init__(self, window: pygame.Surface, connection: mysql.connector.connection.MySQLConnectionAbstract):
        self.window = window
        self.cnx = connection

    def show_menu(self, student_id: int):
        self.id = student_id
        pygame.display.set_caption("Student Menu")
        pygame.display.set_mode([self.width, self.height])

        cursor = self.cnx.cursor(buffered=True)
        args = [self.id, 0]
        curr_name = cursor.callproc("GET_VIEW_NAME", args)[1]

        # display menu items here
        student_menu = pm.Menu(
            title="Student",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_GREEN
        )

        # Create frame and orientation for the content
        content_frame = student_menu.add.frame_v(
            self.width - 100,
            self.height - 200,
            'content',
            background_color=(137, 207, 110),
            padding=0,
        )
        content_title = student_menu.add.frame_h(
            self.width - 100, 52,
            background_color=(180, 180, 180),
            padding=0,
        )
        content_frame.pack(content_title)

        log_out_button = student_menu.add.button(
            "logout",
            action=pm.events.EXIT,
            font_color='white',
            background_color=(240, 88, 88),
            selection_color=(140, 40, 40),
        )
        content_title.pack(
            student_menu.add.label(
                curr_name,
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )
        content_title.pack(log_out_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        """
        CREATING BUTTONS FOR THE MENU
        """

        drop_class_button = student_menu.add.button(
            "Drop Class",
            action=self.drop_class_menu,
            background_color=(86, 131, 68),
            font_color="white",
            selection_color="yellow",

        )

        # drop class button orientation
        content_frame.pack(
            drop_class_button,
            pm.locals.ALIGN_CENTER,
            pm.locals.POSITION_CENTER,
            margin=(0, 10)
        )

        view_schedule_button = student_menu.add.button(
            "View Schedule",
            action=self.view_schedule_menu,
            background_color=(86, 131, 68),
            font_color="white",
            selection_color="yellow",
        )

        # view schedule button orientation
        content_frame.pack(
            view_schedule_button,
            pm.locals.ALIGN_CENTER,
            pm.locals.POSITION_CENTER,
            margin=(0, 10)
        )

        student_menu.mainloop(self.window)

    def drop_class_menu(self):
        # collect class names for the selector
        cursor = self.cnx.cursor(buffered=True)
        cursor.callproc("CLASS_NAMES")
        results = cursor.stored_results()
        items = []
        for item in results:
            items = item.fetchall()

        student_roster_menu = pm.menu.Menu(
            "Drop Class",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_BLUE
        )

        content_frame = student_roster_menu.add.frame_v(
            self.width - 100,
            self.height - 100,
            'content',
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
            action=lambda: self.show_menu(self.id),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_title.pack(
            student_roster_menu.add.label(
                'drop_class',
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

        drop_button = student_roster_menu.add.button(
            "Drop",
            action=lambda:
            self.drop_class(
                self.id,
                selector.get_value()[0][1],
                student_roster_menu,
                content_frame
            ),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_frame.relax(True)

        content_frame.pack(selector, pm.locals.ALIGN_CENTER, margin=(10, 10))
        content_frame.pack(drop_button, pm.locals.ALIGN_CENTER, margin=(0, 10))

        student_roster_menu.mainloop(self.window)

    def drop_class(self, student_id, roster_id, roster_menu, frame):
        # clean the menu before redrawing items
        for widget in frame.get_widgets(True, True, False):
            if "show_roster" in widget.get_id():
                roster_menu.remove_widget(widget)
            if "title" in widget.get_id():
                roster_menu.remove_widget(widget)
            if "class" in widget.get_id():
                roster_menu.remove_widget(widget)

        show_content = roster_menu.add.frame_v(
            self.width - 320,
            800,
            'show_roster',
            background_color='black',
            padding=0,
            max_height=self.height - 300,
            align=pm.locals.ALIGN_CENTER
        )
        show_content.relax(True)
        frame.pack(show_content, align=pm.locals.ALIGN_CENTER, margin=(0, 10))

        frame_title = roster_menu.add.frame_h(
            self.width - 300,
            60,
            font_color='black',
            background_color=(180, 180, 180),
            frame_id='frame_title',
            padding=0
        )

        frame_title.pack(
            roster_menu.add.label(
                f'Updated Schedule: ',
                font_color='black',
                padding=0,
                label_id="title"
            ),
            margin=(10, 10)
        )
        show_content.pack(frame_title, align=pm.locals.ALIGN_CENTER)

        cursor = self.cnx.cursor(buffered=True)
        args = (student_id, roster_id)

        cursor.callproc("DROP_CLASS", args)
        self.cnx.commit()  # don't forget to commit dawg

        # display screen after
        # return the view name to use in the view student schedule procedure
        cursor = self.cnx.cursor(buffered=True)
        args = [self.id, 0]
        view_name = cursor.callproc("GET_VIEW_NAME", args)

        args = [self.id, view_name[1]]

        cursor.callproc("VIEW_STUDENT_SCHEDULE", args)
        items = []
        results = cursor.stored_results()
        for item in results:
            items = item.fetchall()

        i = 0
        # create and display each class on the schedule
        for item in items:
            i += 1
            label_title = f'{i}) {item[1]} | {item[0]}'
            button = roster_menu.add.label(
                label_title,
                label_id=f'class{str(i)}',
                font_color='white',
                background_color="black"
            )

            show_content.pack(button, pm.locals.ALIGN_CENTER, margin=(0, 10))

    def view_schedule_menu(self):
        student_roster_menu = pm.menu.Menu(
            "View Schedule",
            width=self.width,
            height=self.height,
            theme=pm.themes.THEME_BLUE
        )

        content_frame = student_roster_menu.add.frame_v(
            self.width - 100,
            self.height - 100,
            'content',
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
            action=lambda: self.show_menu(self.id),
            font_color='white',
            background_color="navy",
            selection_color='grey'
        )

        content_title.pack(
            student_roster_menu.add.label(
                'view_schedule',
                font_color='black',
                padding=0
            ),
            margin=(2, 2)
        )

        content_title.pack(back_button, pm.locals.ALIGN_RIGHT, margin=(2, 2))

        # add action function that submits a procedure
        # create a lambda function that takes the first and last name and the ID from the selected class

        frame_title = student_roster_menu.add.frame_h(
            self.width - 300, 60, background_color=(180, 180, 180),
            frame_id='frame_title',
            padding=0
        )
        show_content = student_roster_menu.add.frame_v(
            self.width - 320,
            800,
            'show_roster',
            background_color='black',
            padding=0,
            max_height=self.height - 300,
            align=pm.locals.ALIGN_CENTER
        )
        show_content.relax(True)

        frame_title.pack(
            student_roster_menu.add.label(
                'Classes: ',
                font_color='black',
                padding=0,
                label_id='title'
            ),
            margin=(10, 10))

        show_content.relax(True)
        show_content.pack(frame_title)

        # return the view name to use in the view student schedule procedure
        cursor = self.cnx.cursor(buffered=True)
        args = [self.id, 0]
        view_name = cursor.callproc("GET_VIEW_NAME", args)

        args = [self.id, view_name[1]]

        cursor.callproc("VIEW_STUDENT_SCHEDULE", args)
        items = []
        results = cursor.stored_results()
        for item in results:
            items = item.fetchall()

        i = 0
        # create and display each class on the schedule
        for item in items:
            i += 1
            label_title = f'{i}) {item[1]} | {item[0]}'
            button = student_roster_menu.add.label(
                label_title,
                label_id=f'class{str(i)}',
                font_color='white',
                background_color="black"
            )

            show_content.pack(button, pm.locals.ALIGN_CENTER, margin=(0, 10))

        content_frame.relax(True)

        content_frame.pack(show_content, pm.locals.ALIGN_CENTER, pm.locals.POSITION_CENTER, margin=(0, 10))

        student_roster_menu.mainloop(self.window)

