#set -e

CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

#Check if the submission is a java file
if [[ -e student-submission/ListExamples.java ]]
then
    echo "File found. Continuing"
else 
    echo "File not found. Terminating."
    exit
fi


#echo `ls`
#cat `find ./student-submission -name *.txt` 
cp student-submission/ListExamples.java grading-area/ListExamples.java
#cp `find student-submission -name ListExamples.java` grading-area/ListExamples.java
cp TestListExamples.java grading-area/TestListExamples.java
cp -r lib grading-area

cd grading-area
#pwd
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > results.txt

if [[ `grep "Tests run:" results.txt` ]]
then
echo "Test failed. F."
else
echo "Test passed. A."
fi

#grep "OK (" results.txt

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
