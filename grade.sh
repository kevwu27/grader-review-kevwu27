CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -f ListExamples.java ]]
then
    echo 'File found'
else 
    echo 'Wrong file submitted'
    exit
fi 

cp ../TestListExamples.java TestListExamples.java

javac -cp $CPATH *.java 2>compile-error.txt
if [[ $? -ne 0 ]]
then
    cat compile-error.txt
    echo  'File unable to compile'
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples >output.txt 2>&1

grep -q "OK" output.txt
if [[ $? -eq 0 ]]
then
    echo All test passed!
    echo You"'"ve got full score!
    exit
fi

grep -o -e "Failures: [0-9]\+" output.txt 2> numFailure
echo $numFailure

exit