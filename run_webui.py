import webview
if __name__ == '__main__':
    # Create a standard webview window
    window = webview.create_window('Simple browser', 'http://127.0.0.1:8188')
    webview.start()