APP := my-app

CC      := g++
SRC_FMT := cc
CFLAGS  := -O0 -g
LDFLAGS := -lm

SRC_DIRS := src
SRC_DIRS += src/inner_src

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
