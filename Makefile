# All credits to ARMANGAU Etienne

# sudo make

# VARIABLES TO MODIFY
# sources folder (*.cpp)
SRC := sources
# headers folder (*.h)
INC := include
#  main.cpp (your main cpp source code)
MAIN := main.cpp
# name of the generated executable
EXEC := prog

# the main file can be alone or within the sources folder
ifneq ("$(wildcard $(MAIN))","")
	sources := $(MAIN) $(wildcard $(SRC)/*.cpp)
else
	sources := $(wildcard $(SRC)/*.cpp)
endif

# objects files list
objects := $(sources:.cpp=.o)
# dependacies files list
deps    := $(objects:.o=.d)
# compilator's choice
CXX := g++
CPPFLAGS := -I $(INC) -MMD -MP
# compilator's options (you may add some options here)
CXXFLAGS := -std=c++17 -g -Wall -pedantic

# OS name
UNAME := $(shell uname -s)

ifeq ($(UNAME), Linux)
	LDFLAGS  := -L/usr/lib/x86_64-linux-gnu
	LDLIBS   := -lcurl
else
	# if it's Darwin
	CXXFLAGS += -D OSX
	LDFLAGS  := -stdlib=libstdc++
endif

# linking
$(EXEC) : $(objects)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@
	$(RM) $(objects) $(deps)
	 @echo "Compilation done !"

# compilation from source files
$(SRC)/%.o: $(SRC)/%.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $^ -o $@

# subroutine to remove exec
.PHONY: clean
clean:
	$(RM) $(EXEC)

# dependancies between files
-include $(deps)
