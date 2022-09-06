import os


def scandirs(path):
     for root, dirs, files in os.walk(path):
        for currentFile in files: 
            print("processing file: " + currentFile, end=' ')
            exts = ('.import', '.import')
            if currentFile.lower().endswith(exts):
                os.remove(os.path.join(root, currentFile))
                print(' - DELETED - ', end=' ')
            print()


scandirs('./')