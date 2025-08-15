CXX = g++
CXXFLAGS = -Wall -g

OBJS = main.o Radio.o Clock.o RadioClock.o 
TARGET = programa

$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f *.o #(TARGET)
