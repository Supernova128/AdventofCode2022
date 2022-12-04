package main

import (
    "os"
    "bufio"
    "strings"
    "strconv"
    "fmt"
)

func main() {
    // open input file
    file, err := os.Open("input.txt")
    if err != nil {
        panic(err)
    }
    defer file.Close()
    var overlaps1 int = 0
    var overlaps2 int = 0
    // var overlaps int= 0

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        overlaps1 = overlaps1 + overlap(scanner.Text())
    }
    fmt.Println(overlaps1)
    file2, err := os.Open("input.txt")
    scanner2 := bufio.NewScanner(file2)
    for scanner2.Scan() {
        overlaps2 = overlaps2 + overlap2(scanner2.Text())
    }
    fmt.Println(overlaps2)
}

func overlap(x string) int{
    ranges := strings.Split(x, ",")
    nums1 := strings.Split(ranges[0],"-")
    nums2 := strings.Split(ranges[1],"-")

    lower1,err := strconv.Atoi(nums1[0])
    lower2,err := strconv.Atoi(nums2[0])
    upper1,err := strconv.Atoi(nums1[1])
    upper2,err := strconv.Atoi(nums2[1])
    if err != nil {print("error")
   }

    if ((lower1 >= lower2 && upper1 <= upper2) || (lower1 <= lower2 && upper1 >= upper2)){
        return 1
    }else{
        return 0
    }
}

func overlap2(x string) int{
    ranges := strings.Split(x, ",")
    nums1 := strings.Split(ranges[0],"-")
    nums2 := strings.Split(ranges[1],"-")

    lower1,err := strconv.Atoi(nums1[0])
    lower2,err := strconv.Atoi(nums2[0])
    upper1,err := strconv.Atoi(nums1[1])
    upper2,err := strconv.Atoi(nums2[1])
    if err != nil {print("error")
   }
   // print(lower1,upper1,lower2,upper2)
    if ((lower1 > upper2) || (lower2 > upper1)){
        return 0
    }else{
        return 1
    }
}



