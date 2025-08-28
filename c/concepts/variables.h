/*
 * Header file for basic variables and data types concepts
 * 
 * This header declares functions that demonstrate fundamental C concepts
 * including variables, data types, constants, and basic operations.
 */

#ifndef VARIABLES_H
#define VARIABLES_H

// Structure to hold arithmetic operation results
typedef struct {
    int sum;
    int difference;
    int product;
    double quotient;
    int remainder;
} arithmetic_result_t;

// Function declarations

// Basic arithmetic operations
int add_integers(int a, int b);
double calculate_average(double sum, int count);

// Character operations
char to_uppercase(char c);

// Type casting
int double_to_int(double value);

// Utility functions
void print_type_sizes(void);
int demonstrate_scope(void);
void demonstrate_constants(void);

// Advanced arithmetic
arithmetic_result_t perform_arithmetic(int a, int b);

// Global constants
extern const int MAX_STUDENTS;

#endif // VARIABLES_H
