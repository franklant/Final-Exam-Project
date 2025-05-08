import pygame
from UI.buttonbox import ButtonBox

# Name: Franklan Taylor
# Course: COMP267-001
# Date: 4/25/2025
# Description: This program holds the text box module used for the login screen UI. 'pygame' provides graphics
# capabilities to create functionality for the buttons. The text box displays place-holder text and accepts and displays
# user-input to be submitted by the application


class TextBox (ButtonBox):
    default = ""
    text = default
    click_color = "blue"
    border_color = "white"

    def __init__(self, window, x_pos, y_pos, w, h, default="", color="black"):
        super().__init__(window, x_pos, y_pos, w, h, color)
        self.default = default
        self.text = default
        self.color = color
        self.box = pygame.Rect(self.x, self.y, self.w, self.h)
        self.border_box = pygame.Rect(self.x - 10, self.y - 10, self.w + 20, self.h + 20)

    # draw the text box based on its current state
    def draw(self, py: pygame):
        color = self.color
        border_color = self.border_color
        if self.click:
            border_color = self.click_color
        elif self.hover:
            border_color = self.hover_color

        py.draw.rect(self.window, border_color, self.border_box)
        py.draw.rect(self.window, color, self.box)

        # thanks to GeeksForGeeks
        text_surface = self.base_font.render(self.text, False, "White")
        self.window.blit(text_surface, (self.box.x + 5, self.box.y + 5))
        self.box.w = max(self.w, text_surface.get_width() + 10)
        self.border_box.w = max(self.w + 20, text_surface.get_width() + 30)

    # updates the state of the text box depending on if the cursor overlaps with its area
    def clicked(self, py: pygame, event: pygame.event):
        mouse_pos = py.mouse.get_pos()

        if event.type == py.MOUSEBUTTONDOWN:
            if self.box.collidepoint(mouse_pos[0], mouse_pos[1]):
                self.click = True
                if self.text == self.default:
                    self.text = ""
            else:
                self.click = False
        else:
            if self.box.collidepoint(mouse_pos[0], mouse_pos[1]):
                self.hover = True
            else:
                self.hover = False

    # renders the text based on the keys being typed by the user
    def render_text(self, py: pygame, event: pygame.event):
        if self.click:
            # Thanks to Geeks4Geeks
            if event.type == py.KEYDOWN:
                # Check for backspace
                if event.key == py.K_BACKSPACE:
                    # get text input from 0 to -1 i.e. end.
                    self.text = self.text[:-1]
                else:
                    self.text += event.unicode
        else:
            if self.text == "":
                self.text = self.default

    def get_text(self):
        return self.text

