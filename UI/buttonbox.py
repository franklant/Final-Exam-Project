import pygame

# Name: Franklan Taylor
# Course: COMP267-001
# Date: 4/25/2025
# Description: This program holds the button box module used for the login screen UI. 'pygame' provides graphics
# capabilities to create functionality for the buttons.


class ButtonBox:
    window = None
    x = 0
    y = 0
    w = 0
    h = 0
    text = ""
    pygame.font.init()
    base_font = pygame.font.Font(None, 32)
    color = "white"
    hover_color = "grey"
    click_color = "red"
    box = None
    click = False
    hover = False

    def __init__(self, window, x_pos, y_pos, w, h, title="", color="white"):
        self.window = window
        self.x = x_pos
        self.y = y_pos
        self.w = w
        self.h = h
        self.text = title
        self.color = color
        self.box = pygame.Rect(self.x, self.y, self.w, self.h)

    # draw the button based on its current state
    def draw(self, py: pygame):
        color = self.color
        if self.click:
            color = self.click_color
        elif self.hover:
            color = self.hover_color

        py.draw.rect(self.window, color, self.box)

        # thanks to GeeksForGeeks
        text_surface = self.base_font.render(self.text, False, "Black")
        self.window.blit(text_surface, (self.box.x + 5, self.box.y + 5))
        self.box.w = max(self.w, text_surface.get_width() + 10)

    # updates the state of the button depending on if the cursor overlaps its area
    def clicked(self, py: pygame, event: pygame.event):
        mouse_pos = py.mouse.get_pos()

        if self.box.collidepoint(mouse_pos[0], mouse_pos[1]):
            self.hover = True
            if event.type == py.MOUSEBUTTONDOWN:
                self.click = True
                self.hover = False
            else:
                self.click = False
        else:
            self.hover = False

    def is_clicked(self):
        return self.click

