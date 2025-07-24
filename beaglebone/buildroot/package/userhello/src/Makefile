# Name des Binaries
TARGET = userhello

# Compiler und Flags
#CC = arm-buildroot-linux-gnueabihf-gcc 
CC = $(CROSS_COMPILE)gcc
CFLAGS = -Wall -O2

# Standardziel: Binary bauen
all: $(TARGET)

# Binary aus Objektdatei linken
$(TARGET): userhello.o
	$(CC) $(CFLAGS) -o $(TARGET) userhello.o

# Objektdatei aus C-Datei kompilieren
userhello.o: userhello.c
	$(CC) $(CFLAGS) -c userhello.c -o userhello.o

# Aufräumen
clean:
	rm -f $(TARGET) *.o

