//
//  main.swift
//  GradeManagement Struct Edition
//
//  Created by StudentPM on 2/7/25.
//

import Foundation
import CSV

// array containing every student's name, scores, and final score
var students: [Student] = []

//struct determining the variable types
struct Student{
    var name: String
    var finalScore: Double
    var scores: [String]
}

// There are 38 students in this class
var studentsInClass: Double = 38

do{
    let stream = InputStream(fileAtPath:"/Users/studentpm/Desktop/grade.csv")
    let csv = try CSVReader(stream: stream!)
    
    while let row = csv.next(){
        handleData(data: row)
    }
}
catch{
    print("There was an error trying to read the file!")
}

// This runs the main menu function
mainMenu()

// This function makes the main menu
func mainMenu(){
    print("Welcome to the Grade Manager!")
    print("What would you like to do? (Enter the number):")
    print("1. Display grade of a single student")
    print("2. Display all grades for a student")
    print("3. Display all grades of ALL students")
    print("4. Find the average grade of the class")
    print("5. Find the average grade of an assignment")
    print("6. Find the lowest grade in the class")
    print("7. Find the highest grade of the class")
    print("8. Filter students by grade range")
    print("9. Quit")
    
    // click a number from 1-9 to run a specific function, be sure to enter a number within that range
    if let userInput = readLine(), let number = Int(userInput), number > 0, number < 10{
            if number == 1{
                displaySingleStudentGrade()
            }
            if number == 2{
                displayAllSingleStudentGrades()
            }
            if number == 3{
                displayAllStudentsGrades()
            }
            if number == 4{
                averageGradeOfClass()
            }
            if number == 5{
                averageAssignmentGrade()
            }
            if number == 6{
                lowestGradeInClass()
            }
            if number == 7{
                highestGradeInClass()
            }
            if number == 8{
                filterByGradeRange()
            }
            if number == 9{
                quitProgram()
            }
        }
        else{
            print("Enter a valid number!")
            mainMenu()
        }
}

// This function stores all the student's data to students array
func handleData(data: [String]){
    var studentName: String = ""

    var tempScores: [String] = []
    
    for i in data.indices{
        if i == 0{
            studentName = data[i]
        }
        else{
            tempScores.append(data[i])
        }
    }
    
    
    var sum: Double = 0
    
    for score in tempScores{
        if let num = Double(score){
            sum += num
        }
    }
    
    let finalGrade: Double = sum/Double(tempScores.count)
    
    let randomStudent: Student = Student(name: studentName, finalScore: finalGrade, scores: tempScores)
    students.append(randomStudent)
}

// This function displays a students final score after entering their name
func displaySingleStudentGrade(){
    print("Which student would you like to choose?")
        
    // Here it takes the name the user inputs into the line and gets the student's name and final score (and rounds it to the nearest hundreth).
        if let userInput = readLine(){
            for i in students.indices{
                if userInput == students[i].name{
                    print("\(userInput)'s grade for this class is \(round(100.0 * students[i].finalScore)/100.0)")
                }
            }
            
            mainMenu()
        }
        else{
            print("Enter valid student name!")
            mainMenu()
        }
}

// This function display all the scores of a single student
func displayAllSingleStudentGrades(){
    print("Which student would you like to choose?")
        var studentPos: Int = 0;
        
    // This part take the user input and gets the student's name and scores, then prints them
        if let userInput = readLine(){
            for i in students.indices{
                if userInput == students[i].name{
                    studentPos = i
                }
            }
            
            print("\(students[studentPos].name)'s grades for this class are: ", terminator: "")
//            print("\(students[studentPos].scores)", terminator: "")
           for score in students[studentPos].scores{
                print("\(score) ", terminator: "")
            }
            print("")
            mainMenu()
        }
}

// This function display every student's grades
func displayAllStudentsGrades(){
    for i in students.indices{
        print("\(students[i].name)'s scores are: ", terminator: "")
        for score in students[i].scores{
                print("\(score) ", terminator: "")
            }
            print()
        }
        mainMenu()
}

// This function display the average final grade of the class
func averageGradeOfClass(){
    var sumOfGrades: Double = 0
        var averageGrade: Double = 0
        
    // This part takes all the final grades of the class and find the average
        for i in students.indices{
            sumOfGrades += students[i].finalScore
        }
        
        averageGrade = round(100.0 * (sumOfGrades/studentsInClass))/100.0
        
        print("The average grade of this class is \(averageGrade)")
        
        mainMenu()
}

// This function finds the average of an assignment the user chooses
func averageAssignmentGrade(){
    var sumOfAssignments: Int = 0
        print("Which assignment would you like to get the average of (enter a number 0-9):")
            
    // A number is entered in the line and find the average by adding all the numbers of that indice together and dividing
        if let userInput = readLine(), let number = Int(userInput), number < 10{
            for i in students.indices{
                if let score = Int(students[i].scores[number]){
                    sumOfAssignments += score
                }
            }
            
            print("The average for assignment \(number + 1)# is \(round(100.0 * (Double(sumOfAssignments)/studentsInClass))/100.0)")
            mainMenu()
        }
        else{
            print("Enter a valid number!")
            mainMenu()
        }
}

// This function finds the lowest grade in the class
func lowestGradeInClass(){
    // This variable assumes that this indice in the array is the lowest value
    var lowest: Double = students[0].finalScore
    
    //This for loop looks for numbers lower than the variable's value until finally finding the lowest it can find.
    for i in students.indices{
        if students[i].finalScore < lowest{
            lowest = students[i].finalScore
        }
    }
    
    // This for loop is primarily meant to get the student's name, then add the following text along with the lowest score
    for i in students.indices{
        if lowest == students[i].finalScore{
            print("\(students[i].name) is the student with the lowest grade: \(lowest)")
        }
    }
    mainMenu()
}

// This function finds the highest grade in the class
func highestGradeInClass(){
    // This variable assumes that this indice in the array is the highest value
    var highest: Double = students[0].finalScore
    
    // This for loop is looks for numbers higher than the variable's value until finally finding the highest it can find
    for i in students.indices{
        if students[i].finalScore > highest{
            highest = students[i].finalScore
        }
    }
    
    // This for loop is primarily meant to get the student's name, then add the following text along with the highest score
    for i in students.indices{
        if highest == students[i].finalScore{
            print("\(students[i].name) is the student with the highest grade: \(highest)")
        }
    }
    mainMenu()
}

// This function displays every final grade within the range the user chooses
func filterByGradeRange(){
    print("Enter the low range you would like to use:")
        
    // Here you enter a number that has to be less than 100 or greater than -1
        if let lowNumber = readLine(), let lowerNum = Double(lowNumber), lowerNum < 100, lowerNum > -1{
            
            print("Enter the high range you would like to use:")
            // Here you enter a number that has to be higher than the low range and/or equal to or less than 100
            if let highNumber = readLine(), let higherNum = Double(highNumber), higherNum > lowerNum, higherNum < 101{
                
                // This for loop finds all the names and final scores within the chosen range and displays them
                for i in students.indices{
                    if students[i].finalScore >= lowerNum, students[i].finalScore <= higherNum{
                        print("\(students[i].name): \(students[i].finalScore)")
                    }
                }
                
                mainMenu()
            }
            else{
                print("Enter a number higher than the low range or enter a number equal or less than 100")
                mainMenu()
            }
        }
        else{
            print("Enter a number less than 100 or greater than -1!")
            mainMenu()
        }
}

// This function just quits the program
func quitProgram(){
    print("Have a good rest of your day!")
}
