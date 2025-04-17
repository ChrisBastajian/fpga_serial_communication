import serial
import numpy as np

ser = serial.Serial(port='COM7', baudrate=9600, timeout=1)

try:
    while True:
        if ser.in_waiting > 0:
            data = ser.read()
            print(f"Received: {data.hex()} | ASCII: {data.decode(errors='ignore')}")
except KeyboardInterrupt:
    print("\nExiting...")
finally:
    ser.close()