from pyautogui import press, typewrite
import time
if __name__ == "__main__":
    try:
        answer = input("Start Nvim Pokemon Dashboard Testing (y/n)")
        if answer != "y":
            exit()
        print("Starting in 5 Sec")
        time.sleep(1.0 * 5)

        typewrite("nvim")
        press("enter")
        for _ in range(0,100):
            press('q')
            time.sleep(0.05)
            typewrite('nvim')
            time.sleep(0.05)
            press('enter')
            time.sleep(1.0)

        press('q')

    except KeyboardInterrupt:
        exit()
