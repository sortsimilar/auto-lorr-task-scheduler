import subprocess
import sys

bash = r"C:\msys64\msys64\usr\bin\bash.exe"

# Search for packages
result = subprocess.run(
    [bash, "-c", "PATH=/usr/bin:$PATH pacman -Ss libarchive 2>&1"],
    capture_output=True, text=True, timeout=30
)
print("libarchive search:")
print(result.stdout[:2000])

result = subprocess.run(
    [bash, "-c", "PATH=/usr/bin:$PATH pacman -Ss jsoncpp 2>&1"],
    capture_output=True, text=True, timeout=30
)
print("\njsoncpp search:")
print(result.stdout[:2000])

result = subprocess.run(
    [bash, "-c", "PATH=/usr/bin:$PATH pacman -Ss expat 2>&1"],
    capture_output=True, text=True, timeout=30
)
print("\nexpat search:")
print(result.stdout[:2000])
