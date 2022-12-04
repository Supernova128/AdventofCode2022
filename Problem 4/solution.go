package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
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
		var line string = scanner.Text()
		overlaps1 = overlaps1 + overlap(parse(line))
		overlaps2 = overlaps2 + overlap2(parse(line))
	}
	fmt.Println(overlaps1)
	fmt.Println(overlaps2)
}

func parse(x string) (int, int, int, int) {
	ranges := strings.Split(x, ",")
	nums1 := strings.Split(ranges[0], "-")
	nums2 := strings.Split(ranges[1], "-")
	lower1, err := strconv.Atoi(nums1[0])
	lower2, err := strconv.Atoi(nums2[0])
	upper1, err := strconv.Atoi(nums1[1])
	upper2, err := strconv.Atoi(nums2[1])
	if err != nil {
		print("error")
	}
	return lower1, lower2, upper1, upper2
}

func overlap(lower1 int, lower2 int, upper1 int, upper2 int) int {

	if (lower1 >= lower2 && upper1 <= upper2) || (lower1 <= lower2 && upper1 >= upper2) {
		return 1
	} else {
		return 0
	}
}

func overlap2(lower1 int, lower2 int, upper1 int, upper2 int) int {
	if (lower1 > upper2) || (lower2 > upper1) {
		return 0
	} else {
		return 1
	}
}
