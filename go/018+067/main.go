package main

import (
	"bufio"
	"fmt"
	"math"
	"net/http"
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

func max(arr []int) int {
	var m int = math.MinInt
	for _, i := range arr {
		if i > m {
			m = i
		}
	}
	return m
}

func main() {
	// r, err := os.Open("pyramid.txt")
	req, err := http.NewRequest("GET", "https://projecteuler.net/project/resources/p067_triangle.txt", nil)
	check(err)
	req.Header.Set("User-Agent", "")
	client := &http.Client{}
	res, err := client.Do(req)
	check(err)
	defer res.Body.Close()
	r := res.Body
	scanner := bufio.NewScanner(r)
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
	fmt.Println(max(front))
}
