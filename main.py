import customtkinter as ctk
import serial
import time

ctk.set_appearance_mode("light_gray")

#Color Theme:
ctk.set_default_color_theme("dark-blue")

#create App class:
class App(ctk.CTk):
    # Layout of the GUI:
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.title("FPGA Serial Communication")
        width = self.winfo_screenwidth()
        height = self.winfo_screenheight()
        self.geometry(str(width)+"x"+ str(height)) #I picked the size of the window to be that of the system's
        #self.geometry("1280x720")
        self.configure(fg="#333333")

        #Instructions to user:
        self.instructions = ctk.CTkLabel(text="Instructions:", master=self)
        self.instructions.place(x=0.05*width, y=0.01*height)
        self.instructions.configure(font=("times", 20, "bold"))
        self.instructions_lbl1 = ctk.CTkLabel(text="1) Start by selecting the \"COM\" port "
                                                  "that the FPGA is connected to.", master=self)
        self.instructions_lbl1.place(x=0.05*width, y=0.05*height)
        self.instructions_lbl1.configure(font=("times", 20))
        self.instructions_lbl2 = ctk.CTkLabel(text="2) Then, Press the \"OPERATE\""
                                                   "button and the Binary Result will "
                                                "be returned from the FPGA below.", master=self)
        self.instructions_lbl2.place(x=0.05*width, y=0.1*height)
        self.instructions_lbl2.configure(font=("times", 20))

        #COM network selection button:
        self.com_btn = ctk.CTkOptionMenu(master=self, values=["COM1", "COM2", "COM3", "COM4",
                                                              "COM5", "COM6", "COM7"])
        self.com_btn.place(x=0.5*width, y=0.20*height, anchor="center")
        self.com_btn.configure(width=0.1*width, height=0.03*height)

        # For A and B labels:
        #self.a_lbl = ctk.CTkLabel(text="A", master=self)
        #self.b_lbl = ctk.CTkLabel(text="B", master=self)

        # Position and size of A and B labels:
        sep_x = width / 3
        y_pos = 0.3 * height  # 30 percent of the window down...
        #self.a_lbl.place(x=sep_x, y=y_pos, anchor='center')
        #self.b_lbl.place(x=2 * sep_x, y=y_pos, anchor='center')
        #self.a_lbl.configure(font=("times", 50))
        #self.b_lbl.configure(font=("times", 50))

        #User input:
        #self.a_in = ctk.CTkEntry(master=self)
        #self.b_in = ctk.CTkEntry(master=self)
        #inputs = [self.a_in, self.b_in]
        #y_pos = 0.35 * height #updating y to 35% of the position down, but we want them at the same
                                #x level as the labels (so they're right below 'A' and 'B'
        #i = 0
        #for input in inputs:
        #    i +=1
        #    input.place(x=i*sep_x, y=y_pos, anchor='center')


        #Create option buttons and have "self" as the master plus store in self to use them in functions
        self.and_btn = ctk.CTkButton(text="OPERATE", master=self, command=self.operate)
        #self.or_btn = ctk.CTkButton(text="OR", master=self, command=self.ore) #cannot use or so I use ore lol
        #self.add_btn = ctk.CTkButton(text="ADD", master=self, command=self.add)
        #self.diff_btn = ctk.CTkButton(text="DIFFERENCE", master=self, command=self.diff)
        #op_btns = [self.and_btn, self.or_btn, self.add_btn, self.diff_btn] #storing buttons

        #Position the buttons:
        #num_ops = 4 #4 operations
        #sep_x =  width/(num_ops+1) #dividing the geometry equally for x
        y_pos = 0.55*height #lowest y = height

        self.and_btn.place(x=width//2, y=y_pos, anchor='center')
        #self.or_btn.place(x=2*sep_x, y=y_pos, anchor='center')
        #self.add_btn.place(x=3*sep_x, y=y_pos, anchor='center')
        #self.diff_btn.place(x=4*sep_x, y=y_pos, anchor='center')

        #configuring size of buttons:
        #for btn in op_btns:
        #    btn.configure(width=200, height=150, font=("times", 20))
        self.and_btn.configure(width=200, height=150, font=("times", 20))
        #Result Title:
        self.result_ttl = ctk.CTkLabel(text="Result:", master=self)
        self.result_ttl.place(x=0.05*width, y=0.7*height)
        self.result_ttl.configure(font=("times", 20, "bold"))
        #Results Textbox:
        self.result = ctk.CTkEntry(master=self, state="disabled") #disabled state so user cannot edit
        self.result.place(x=0.5* width, y=0.75*height, anchor='center')
        self.result.configure(font=("times", 20, "bold"), width=0.9*width, height=0.01*height)

    #Functions:
    def operate(self):
        sel = "11"
        #A = self.a_in.get()
        #B = self.b_in.get()
        #AB =  str(A) + str(B)
        #message = str(sel)+AB

        #Send to COM port:
        COM = self.com_btn.get()
        self.trigger_serial(sel, COM)

    def ore(self):
        sel = "01"
        A = self.a_in.get()
        B = self.b_in.get()
        AB =  str(A) + str(B)
        message = str(sel)+AB

        #Send to COM port:
        COM = self.com_btn.get()
        self.send_to_serial(message, COM)
        print("or")

    def add(self):
        sel = "10"
        A = self.a_in.get()
        B = self.b_in.get()
        AB =  str(A) + str(B)
        message = str(sel)+AB

        #Send to COM port:
        COM = self.com_btn.get()
        self.send_to_serial(message, COM)
        print("add")

    def diff(self):
        sel = "11"
        A = self.a_in.get()
        B = self.b_in.get()
        AB =  str(A) + str(B)
        message = str(sel)+AB

        #Send to COM port:
        COM = self.com_btn.get()
        self.send_to_serial(message, COM)
        print("diff")

    def receive_from_serial(self):
        ser = self.ser
        try:
            print("Receiving data:")
            while True:
                if ser.in_waiting > 0:
                    data = ser.read()
                    print(f"Received: {data}")

        except KeyboardInterrupt:
            print("\nExiting...")
        ser.close()
        return #remove this line when you add the code for this function (remove "return")

    def send_to_serial(self, message, com):
        usb_port = com
        num_18bit = int(message, 2)
        num_18bit = num_18bit & 0b111111111111111111  #mask to 18 bits

        high_byte = (num_18bit >> 16) & 0xFF  # Get top 2 bits
        mid_byte = (num_18bit >> 8) & 0xFF
        low_byte = num_18bit & 0xFF  # gets lower 8 bits

        print(
            f"Sending:\n  High Byte = {format(high_byte, '08b')}\n  Mid Byte = {format(mid_byte, '08b')}\n  Low Byte = {format(low_byte, '08b')}")

        self.result.configure(state="normal")  # Enable editing temporarily
        self.result.delete(0, ctk.END)
        # Send to FPGA
        self.ser = serial.Serial(com, 9600, timeout=1)
        self.ser.write(bytes([mid_byte, low_byte, high_byte, high_byte, high_byte,high_byte, high_byte]))
        self.answer = self.ser.read()
        byte_value = self.answer[0]
        binary_string = format(byte_value, '08b')
        self.result.insert(0, binary_string)
        self.result.configure(state="disabled")  # Re-disable after update
        self.ser.close()

    def trigger_serial(self, message, com):
        message = int(message, 2) & 0xFF
        self.result.configure(state="normal")  # Enable editing temporarily
        self.result.delete(0, ctk.END)
        # Send to FPGA
        self.ser = serial.Serial(com, 9600, timeout=1)
        self.ser.write(bytes(message))


        self.answer = self.ser.read()
        byte_value = self.answer[0]
        binary_string = format(byte_value, '08b')
        self.result.insert(0, binary_string)
        self.result.configure(state="disabled")  # Re-disable after update
        self.ser.close()
if __name__ == "__main__":
    app = App()
    app.mainloop()