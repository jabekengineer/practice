hello-demo: hello
	echo "Running Demo"
	$(BUILD_DIR)/hello

hello: hello.o
	cc -o $(BUILD_DIR)/hello $(BUILD_DIR)/hello.o

hello.o:
	cc -c $(SRC_DIR)/hello.c -o $(BUILD_DIR)/hello.o

clean:
	rm $(BUILD_DIR)/hello.o $(BUILD_DIR)/hello