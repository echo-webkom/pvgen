CC = clang
FLAGS = -Iinclude -Wall -Wextra -Wpedantic -Werror -Wshadow -Wconversion -Wunreachable-code -fsanitize=undefined -fsanitize=address
DEBUG_FLAGS = -g -Og
RELEASE_FLAGS = -O3 -flto
OBJDIR = bin
TARGET = pvgen

SRC = $(wildcard src/*.c) $(wildcard src/*/*.c) $(wildcard src/*/*/*.c)
OBJS = $(patsubst src/%, $(OBJDIR)/%, $(SRC:.c=.o))

all: $(TARGET)
	mkdir -p temp

$(TARGET): $(OBJS)
	$(CC) $(DEBUG_FLAGS) $(FLAGS) -o $@ $^ -DDEBUG

$(OBJDIR)/%.o: src/%.c | $(OBJDIR)
	mkdir -p $(@D) && $(CC) $(FLAGS) -DDEBUG -c $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

clean:
	rm -f *.exe *.zip gmon.out log
	rm -rf temp bin dist

release:
	$(CC) $(FLAGS) $(RELEASE_FLAGS) $(SRC) 