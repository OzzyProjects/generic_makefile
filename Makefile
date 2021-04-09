# ARMANGAU Etienne makefile cpp

# pour générer l’exécutable, faites la commande sudo make dans le répertoire de votre projet/makefile.

# VARIABLES A MODIFIER SELON VOTRE ENVIRONEMENT ET VOS GOUTS

# répertoire des fichiers sources (*.cpp)
SRC := sources
# répertoire des fichiers headers (*.h)
INC := include
# nom du fichier main.cpp (à modifier absolument)
MAIN := main.cpp
# nom de l’exécutable qui va être généré (à modifier)
EXEC := prog

# A NE PAS TOUCHER
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
LDFLAGS  := -L /usr/lib/x86_64-linux-gnu
LDLIBS   := -lcurl

# édition de liens
$(EXEC) : $(objects)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@
	$(RM) $(objects) $(deps)
	 @echo "Compilation réussie !"

# compilation des fichiers sources
$(SRC)/%.o: $(SRC)/%.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $^ -o $@

# routine pour supprimer l’exécutable
.PHONY: clean
clean:
	$(RM) $(EXEC)

# on prend en compte les dépendances entre les fichiers
-include $(deps)