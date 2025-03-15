import customtkinter as ctk
import tkinter as tk
import numpy as np

ctk.set_appearance_mode("light_gray")

#Color Theme:
ctk.set_default_color_theme("dark-blue")

#create App class:
class App(ctk.CTk):
    # Layout of the GUI:
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.title("FPGA Serial Communication")
        width = 1280
        height = 720
        self.geometry(str(width)+"x"+ str(height)) #I picked a standard size for the application
        #self.geometry("1280x720")
        self.configure(fg="#333333")

        #Create buttons and have "self" as the master plus store in self to use them in functions
        self.xor_btn = ctk.CTkButton(text="XOR", master=self)
        self.or_btn = ctk.CTkButton(text="OR", master=self)
        self.add_btn = ctk.CTkButton(text="ADD", master=self)
        self.diff_btn = ctk.CTkButton(text="DIFFERENCE", master=self)
        op_btns = [self.xor_btn, self.or_btn, self.add_btn, self.diff_btn] #storing buttons

        #Position the buttons:
        num_ops = 4 #4 operations
        sep_x =  width/num_ops #dividing the geometry equally for x
        y_pos = 500#lowest y is 720

        self.xor_btn.place(x=sep_x, y=y_pos, anchor='center')
        self.or_btn.place(x=2*sep_x, y=y_pos, anchor='center')
        self.add_btn.place(x=3*sep_x, y=y_pos, anchor='center')
        self.diff_btn.place(x=4*sep_x, y=y_pos, anchor='center')

        #configuring size of buttons:
        for btn in op_btns:
            btn.configure(width=200, height=150)

if __name__ == "__main__":
    app = App()
    app.mainloop()