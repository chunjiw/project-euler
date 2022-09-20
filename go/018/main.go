package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func text2nums(txt string) []int {
	nums := []int{}
	for _, snum := range strings.Split(txt, " ") {
		num, err := strconv.Atoi(snum)
		check(err)
		nums = append(nums, num)
	}
	return nums
}

func main() {
	f, err := os.Open("pyramid.txt")
	check(err)
	scanner := bufio.NewScanner(f)
	var front []int
	var newfront []int
	if scanner.Scan() {
		front = text2nums(scanner.Text())
	} else {
		panic("Failed to get first number")
	}
	for scanner.Scan() {
		newfront = text2nums(scanner.Text())
		for i := range newfront {
			if i == 0 {
				newfront[i] += front[0]
			} else if i == len(newfront)-1 {
				newfront[i] += front[i-1]
			} else {
				if front[i] > front[i-1] {
					newfront[i] += front[i]
				} else {
					newfront[i] += front[i-1]
				}
			}
		}
		front = newfront
	}
	fmt.Println(front)
}
