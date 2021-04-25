# ARMANGAU Etienne makefile cpp

# Make sure you have lcurl installed
# if not sudo apt-get install libcurl4-openssl-dev

# To generate the exec file, just do sudo make on your prompt

# VARIABLES TO MODIFY

# sources folder (*.cpp)
SRC := sources
# headers folder (*.h)
INC := include
#  main.cpp (your main cpp source code)
MAIN := main.cpp
# name of the generated executable
EXEC := prog

# DO NOT TOUCH
# liste des fichiers sources y compris le main.cpp qui peut être dans les sources ou dans
# le répertoire courant du projet
ifneq ("$(wildcard $(MAIN))","")
	sources := $(MAIN) $(wildcard $(SRC)/*.cpp)
else
	sources := $(wildcard $(SRC)/*.cpp)
endif

# liste des fichiers objets
objects := $(sources:.cpp=.o)
# liste des fichier de dépendance
deps    := $(objects:.o=.d)
# choix du compilateur
CXX := g++
CPPFLAGS := -I $(INC) -MMD -MP
# options du compilateur
CXXFLAGS := -std=c++17 -Wall -pedantic

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

# édition de liens
$(EXEC) : $(objects)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@
	$(RM) $(objects) $(deps)
	 @echo "Compilation done !"

# compilation des fichiers sources
$(SRC)/%.o: $(SRC)/%.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $^ -o $@

# routine pour supprimer l’exécutable
.PHONY: clean
clean:
	$(RM) $(EXEC)

# on prend en compte les dépendances entre les fichiers
-include $(deps)
