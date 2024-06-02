APP := my-app

CC      := g++
SRC_FMT := cpp # Source file format like cpp, cxx, cc and ...
CFLAGS  := -g -O0
LDFLAGS := # Linker Flags

SRC_DIRS := src_directory_1
SRC_DIRS += src_directory_2
SRC_DIRS += outter_src_directory/inner_src_directory

SRCS := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.$(SRC_FMT)))
OBJS := $(patsubst %.$(SRC_FMT),bin/%.o,$(SRCS))
DEPS := $(patsubst %.$(SRC_FMT),bin/%.d,$(SRCS))

all: bin/$(APP)

bin/$(APP): $(OBJS)
	@$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

bin/%.o: %.$(SRC_FMT)
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -MMD -MP -MF $(patsubst %.o,%.d,$@) -MT $@ -c $< -o $@

-include $(DEPS)

install: bin/$(APP)
	@cp bin/$(APP) /usr/bin

clean:
	@rm -rf bin $(APP)
