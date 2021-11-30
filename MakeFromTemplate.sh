#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Usage: $(basename $0) daynumber"
  exit 1
fi

DAYNUMBER=$1
cp "Template/DayX.swift" "AdventOfCode2021/Day${DAYNUMBER}.swift"
sed -i '' "s/DayX_Number/$DAYNUMBER/" "AdventOfCode2021/Day${DAYNUMBER}.swift"
sed -i '' "s/DayX/Day$DAYNUMBER/" "AdventOfCode2021/Day${DAYNUMBER}.swift"

cp "Template/DayXTests.swift" "AdventOfCode2021Tests/Day${DAYNUMBER}Tests.swift"
sed -i '' "s/DayX_Number/$DAYNUMBER/" "AdventOfCode2021Tests/Day${DAYNUMBER}Tests.swift"
sed -i '' "s/DayX/Day$DAYNUMBER/" "AdventOfCode2021Tests/Day${DAYNUMBER}Tests.swift"

touch "AdventOfCode2021Tests/InputData/Day${DAYNUMBER}_Example.txt"
touch "AdventOfCode2021Tests/InputData/Day${DAYNUMBER}_MyInput.txt"

echo "Done! Just add to Xcodeproj"
open "AdventOfCode2021"
open "AdventOfCode2021Tests"
